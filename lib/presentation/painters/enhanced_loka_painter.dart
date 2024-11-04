// lib/presentation/painters/enhanced_loka_painter.dart
// import 'dart:ui' as ui;
// ignore_for_file: cascade_invocations

import 'package:flutter/material.dart';
import 'package:triloka_rpg/domain/models/loka_path.dart';
import 'package:triloka_rpg/domain/models/render_state.dart';
import 'package:triloka_rpg/domain/models/transform_3d.dart';
import 'package:triloka_rpg/presentation/effects/post_processing.dart';
import 'package:triloka_rpg/presentation/effects/shader_effects.dart';

class EnhancedLokaPainter extends CustomPainter {
  
  EnhancedLokaPainter({
    required this.transform,
    required this.renderState,
  }) {
    _shaderEffects = ShaderEffects();
    _postProcessing = PostProcessing();
  }
  final Transform3D transform;
  final RenderState renderState;
  late final ShaderEffects _shaderEffects;
  late final PostProcessing _postProcessing;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    _setupCanvas(canvas, size);

    if (renderState.enablePostProcessing) {
      _postProcessing.beginPostProcessing(canvas, size);
    }

    _drawAllPaths(canvas, size);

    if (renderState.enablePostProcessing) {
      _postProcessing.endPostProcessing(canvas);
    }

    canvas.restore();
  }

  void _setupCanvas(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final matrix = transform.asMatrix4();
    canvas.transform(matrix.storage);
  }

  void _drawAllPaths(Canvas canvas, Size size) {
    final paths = _createLokaPaths(size);
    
    // Sort paths by depth for correct rendering
    paths.sort((a, b) => b.depth.compareTo(a.depth));

    for (final lokaPath in paths) {
      _drawEnhancedPath(canvas, lokaPath);
    }
  }

  void _drawEnhancedPath(Canvas canvas, LokaPath lokaPath) {
    if (renderState.enableNormalMapping) {
      _shaderEffects.applyNormalMapping(canvas, lokaPath);
    }

    _shaderEffects.applyAmbientOcclusion(
      canvas, 
      lokaPath.path,
      renderState.ambientIntensity,
    );

    _shaderEffects.applyShadow(
      canvas,
      lokaPath.path,
      renderState.shadowSoftness,
    );

    // Draw main shape with lighting
    final fillPaint = _shaderEffects.createLightingPaint(
      lokaPath.fillColor,
      renderState.lightPosition,
      lokaPath.normalScale,
    );
    canvas.drawPath(lokaPath.path, fillPaint);

    // Draw stroke
    final strokePaint = Paint()
      ..color = lokaPath.strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(lokaPath.path, strokePaint);
  }

  List<LokaPath> _createLokaPaths(Size size) {
    return [
      // Layer 1 Copy
      LokaPath(
        path: _createPath1Copy(size),
        fillColor: const Color.fromARGB(255, 48, 226, 25),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'layer1_copy',
        depth: 50,
      ),
      
      // Layer 1
      LokaPath(
        path: _createPath1(size),
        fillColor: const Color.fromARGB(255, 48, 226, 25),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'layer1',
        depth: 40,
      ),

      // 2D Loka Duplicated Back
      LokaPath(
        path: _createPathDuplicatedBack(size),
        fillColor: const Color.fromARGB(255, 61, 157, 67),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'duplicated_back',
        depth: 30,
      ),

      // Bottom Connect Plane Layer 01
      LokaPath(
        path: _createBottomConnectPath(size),
        fillColor: const Color.fromARGB(255, 226, 25, 25),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'bottom_connect',
        depth: 20,
      ),

      // Middle Connect Plane Layer 01
      LokaPath(
        path: _createMiddleConnectPath(size),
        fillColor: const Color.fromARGB(255, 226, 25, 25),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'middle_connect',
        depth: 10,
      ),

      // Upper Middle Connect Layer 01
      LokaPath(
        path: _createUpperMiddleConnectPath(size),
        fillColor: const Color.fromARGB(255, 194, 45, 45),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'upper_middle_connect',
      ),

      // Upper Connect Plane Layer 01
      LokaPath(
        path: _createUpperConnectPath(size),
        fillColor: const Color.fromARGB(255, 226, 25, 25),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'upper_connect',
        depth: -10,
      ),

      // Loka 2D Layer Original
      LokaPath(
        path: _createOriginalPath(size),
        fillColor: const Color.fromARGB(255, 10, 198, 204),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'original',
        depth: -20,
      ),
    ];
  }

  Path _createPath1Copy(Size size) {
    return Path()
      ..moveTo(size.width * 0.2500000, size.height * 0.1250000)
      ..lineTo(size.width * 0.8125000, 0)
      ..lineTo(size.width * 0.9375000, size.height * 0.2187500)
      ..lineTo(size.width * 0.8125000, size.height * 0.4375000)
      ..lineTo(size.width, size.height * 0.8750000)
      ..lineTo(size.width * 0.4375000, size.height)
      ..lineTo(size.width * 0.2500000, size.height * 0.5625000)
      ..lineTo(size.width * 0.3750000, size.height * 0.3437500);
  }

  // ... Similar methods for all other paths ...
  // Implementation of _createPath1, _createPathDuplicatedBack, etc.

  Path _createPath1(Size size) {
    return Path()
      ..moveTo(size.width * 0.2500000, size.height * 0.1250000)
      ..lineTo(size.width * 0.8125000, 0)
      ..lineTo(size.width * 0.9375000, size.height * 0.2187500)
      ..lineTo(size.width * 0.8125000, size.height * 0.4375000)
      ..lineTo(size.width, size.height * 0.8750000)
      ..lineTo(size.width * 0.4375000, size.height)
      ..lineTo(size.width * 0.2500000, size.height * 0.5625000)
      ..lineTo(size.width * 0.3750000, size.height * 0.3437500);
  }

  Path _createPathDuplicatedBack(Size size) {
    return Path()
      ..moveTo(size.width * 0.8125000, 0)
      ..lineTo(size.width * 0.9375000, size.height * 0.2187500)
      ..lineTo(size.width * 0.8125000, size.height * 0.4375000)
      ..lineTo(size.width, size.height * 0.8750000)
      ..lineTo(size.width * 0.5625000, size.height * 0.8750000)
      ..lineTo(size.width * 0.7500000, size.height * 0.4375000)
      ..lineTo(size.width * 0.6250000, size.height * 0.2187500)
      ..lineTo(size.width * 0.7500000, 0);
  }

  Path _createBottomConnectPath(Size size) {
    return Path()
      ..moveTo(size.width * 0.4375000, size.height)
      ..lineTo(size.width, size.height * 0.8750000)
      ..lineTo(size.width * 0.5625000, size.height * 0.8750000)
      ..lineTo(0, size.height);
  }

  Path _createMiddleConnectPath(Size size) {
    return Path()
      ..moveTo(size.width * 0.2500000, size.height * 0.5625000)
      ..lineTo(size.width * 0.8125000, size.height * 0.4375000)
      ..lineTo(size.width * 0.7500000, size.height * 0.4375000)
      ..lineTo(size.width * 0.1875000, size.height * 0.5625000);
  }

  Path _createUpperMiddleConnectPath(Size size) {
    return Path()
      ..moveTo(size.width * 0.9375000, size.height * 0.2187500)
      ..lineTo(size.width * 0.6250000, size.height * 0.2187500)
      ..lineTo(size.width * 0.0625000, size.height * 0.3437500)
      ..lineTo(size.width * 0.3750000, size.height * 0.3437500);
  }

  Path _createUpperConnectPath(Size size) {
    return Path()
      ..moveTo(size.width * 0.1875000, size.height * 0.1250000)
      ..lineTo(size.width * 0.7500000, 0)
      ..lineTo(size.width * 0.8125000, 0)
      ..lineTo(size.width * 0.2500000, size.height * 0.1250000);
  }

  Path _createOriginalPath(Size size) {
    return Path()
      ..moveTo(size.width * 0.2500000, size.height * 0.1250000)
      ..lineTo(size.width * 0.3750000, size.height * 0.3437500)
      ..lineTo(size.width * 0.2500000, size.height * 0.5625000)
      ..lineTo(size.width * 0.4375000, size.height)
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.1875000, size.height * 0.5625000)
      ..lineTo(size.width * 0.0625000, size.height * 0.3437500)
      ..lineTo(size.width * 0.1875000, size.height * 0.1250000);
  }

  @override
  bool shouldRepaint(covariant EnhancedLokaPainter oldDelegate) {
    return oldDelegate.transform != transform ||
           oldDelegate.renderState != renderState;
  }
}
