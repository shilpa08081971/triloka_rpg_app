// lib/presentation/painters/enhanced_3d_painter.dart

// ignore_for_file: cascade_invocations

// lib/presentation/painters/enhanced_3d_painter.dart
// import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:triloka_rpg/domain/models/loka_path.dart';
import 'package:triloka_rpg/domain/models/mesh_3d.dart';
import 'package:triloka_rpg/domain/models/render_state.dart';
import 'package:triloka_rpg/domain/models/transform_3d.dart';
import 'package:triloka_rpg/presentation/effects/shader_effects.dart';
// import 'package:triloka_rpg/presentation/effects/post_processing.dart';

class Enhanced3DPainter extends CustomPainter {
  
  Enhanced3DPainter({
    required this.transform,
    required this.renderState,
    required this.mesh,
  }) {
    _shaderEffects = ShaderEffects();
  }
  final Transform3D transform;
  final RenderState renderState;
  final Mesh3D mesh;
  late final ShaderEffects _shaderEffects;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    
    // Apply view transform
    final viewMatrix = Matrix4.identity()
      ..setEntry(3, 2, 0.001) // perspective
      ..translate(size.width / 2, size.height / 2, -500)
      ..multiply(transform.asMatrix4());
    
    // Transform vertices
    final transformedVertices = mesh.vertices.map(
      (v) => v.transformed(viewMatrix),
    ).toList();
    
    // Sort faces by depth
    final sortedFaces = List<Face3D>.from(mesh.faces)
      ..sort((a, b) {
        final aZ = a.indices.fold<double>(
          0,
          (sum, idx) => sum + transformedVertices[idx].z,
        ) / a.indices.length;
        
        final bZ = b.indices.fold<double>(
          0,
          (sum, idx) => sum + transformedVertices[idx].z,
        ) / b.indices.length;
        
        return bZ.compareTo(aZ);
      });

    // Draw faces with effects
    for (final face in sortedFaces) {
      final path = Path();
      
      // Create face path
      path.moveTo(
        transformedVertices[face.indices[0]].x,
        transformedVertices[face.indices[0]].y,
      );
      
      for (var i = 1; i < face.indices.length; i++) {
        path.lineTo(
          transformedVertices[face.indices[i]].x,
          transformedVertices[face.indices[i]].y,
        );
      }
      path.close();

      // Apply effects
      if (renderState.enableNormalMapping) {
        _shaderEffects.applyNormalMapping(
          canvas,
          LokaPath(
            path: path,
            fillColor: face.color,
            strokeColor: Colors.blue,
            name: 'face',
          ),
        );
      }

      _shaderEffects.applyAmbientOcclusion(
        canvas,
        path,
        renderState.ambientIntensity,
      );

      _shaderEffects.applyShadow(
        canvas,
        path,
        renderState.shadowSoftness,
      );

      // Draw face
      final paint = _shaderEffects.createLightingPaint(
        face.color,
        renderState.lightPosition,
        1,
      );
      
      canvas.drawPath(path, paint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant Enhanced3DPainter oldDelegate) {
    return oldDelegate.transform != transform ||
           oldDelegate.renderState != renderState;
  }
}
