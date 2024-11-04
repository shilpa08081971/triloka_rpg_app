// lib/presentation/effects/shader_effects.dart
// ignore_for_file: cascade_invocations

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:triloka_rpg/domain/models/loka_path.dart';

class ShaderEffects {
  final Map<Color, ui.Shader> _shaderCache = {};

  ui.Shader _getShaderForColor(Color baseColor, Offset lightPosition) {
    return _shaderCache.putIfAbsent(baseColor, () {
      const bounds = Rect.fromLTWH(0, 0, 1, 1);
      return RadialGradient(
        center: Alignment(lightPosition.dx, lightPosition.dy),
        radius: 1,
        colors: [
          baseColor,
          baseColor.withAlpha((baseColor.alpha * 0.8).toInt()),
        ],
        stops: const [0.0, 1.0],
      ).createShader(bounds);
    });
  }

  Paint createLightingPaint
  (Color baseColor, Offset lightPosition, double normalScale) {
    return Paint()
      ..shader = _getShaderForColor(baseColor, lightPosition)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, normalScale);
  }

  void applyNormalMapping(Canvas canvas, LokaPath lokaPath) {
    final normalPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset.zero,
        const Offset(0, 1),
        [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.2),
        ],
      );
    
    canvas..saveLayer(
      lokaPath.path.getBounds(),
      normalPaint,
    )
    ..drawPath(lokaPath.path, normalPaint)
    ..restore();
  }

  void applyAmbientOcclusion(Canvas canvas, Path path, double intensity) {
    final occlusionPaint = Paint()
      ..color = Colors.black.withOpacity(intensity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    
    canvas.saveLayer(
      path.getBounds().inflate(4),
      Paint()..blendMode = BlendMode.multiply,
    );
    
    canvas.save();
    canvas.translate(2, 2);
    canvas.drawPath(path, occlusionPaint);
    canvas.restore();
    
    canvas.restore();
  }

  void applyShadow(Canvas canvas, Path path, double softness) {
    final bounds = path.getBounds();
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = MaskFilter.blur(
        BlurStyle.normal,
        softness * 3,
      );
    
    canvas.saveLayer(
      bounds.inflate(softness * 4),
      Paint(),
    );
    
    canvas.translate(4, 4);
    canvas.drawPath(path, shadowPaint);
    
    canvas.restore();
  }

  void applySpecularHighlight(
    Canvas canvas,
    Path path,
    Offset lightPosition,
    double intensity,
  ) {
    final specularPaint = Paint()
      ..shader = ui.Gradient.radial(
        Offset(
          lightPosition.dx * path.getBounds().width,
          lightPosition.dy * path.getBounds().height,
        ),
        path.getBounds().width * 0.5,
        [
          Colors.white.withOpacity(intensity),
          Colors.white.withOpacity(0),
        ],
      )
      ..blendMode = BlendMode.screen;

    canvas.saveLayer(
      path.getBounds(),
      Paint(),
    );
    
    canvas.drawPath(path, specularPaint);
    
    canvas.restore();
  }

  void dispose() {
    _shaderCache.clear();
  }
}

// import 'package:flutter/material.dart';
// import 'dart:ui'as ui;
// import '../../domain/models/loka_path.dart';

// class ShaderEffects {
//   final Map<Color, ui.Gradient> _gradientCache = {};

//   ui.Gradient _getGradientForColor(Color baseColor, Offset lightPosition) {
//     return _gradientCache.putIfAbsent(baseColor, () {
//       final Rect bounds = Rect.fromLTWH(0, 0, 1, 1);
//       return RadialGradient(
//         center: Alignment(lightPosition.dx, lightPosition.dy),
//         radius: 1.0,
//         colors: [
//           baseColor,
//           baseColor.withAlpha((baseColor.alpha * 0.8).toInt()),
//         ],
//         stops: const [0.0, 1.0],
//       ).createShader(bounds);
//     });
//   }

//   Paint createLightingPaint
//(Color baseColor, Offset lightPosition, double normalScale) {
//     return Paint()
//       ..shader = _getGradientForColor(baseColor, lightPosition)
//       ..maskFilter = MaskFilter.blur(BlurStyle.normal, normalScale);
//   }

//   void applyNormalMapping(Canvas canvas, LokaPath lokaPath) {
//     // Normal mapping implementation
//     final Paint normalPaint = Paint()
//       ..style = PaintingStyle.fill
//       ..shader = ui.Gradient.linear(
//         Offset.zero,
//         const Offset(0, 1),
//         [
//           Colors.white.withOpacity(0.5),
//           Colors.white.withOpacity(0.2),
//         ],
//       );
    
//     canvas.saveLayer(
//       lokaPath.path.getBounds(),
//       normalPaint,
//     );
//     canvas.drawPath(lokaPath.path, normalPaint);
//     canvas.restore();
//   }

//   // ... Rest of ShaderEffects implementation remains the same ...
// }
