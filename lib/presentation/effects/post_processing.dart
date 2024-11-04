// lib/presentation/effects/post_processing.dart
import 'dart:ui' as ui;

class PostProcessing {

  PostProcessing() {
    _initializeEffects();
  }
  late final ui.ImageFilter _bloomEffect;

  void _initializeEffects() {
    _bloomEffect = ui.ImageFilter.blur(
      sigmaX: 2,
      sigmaY: 2,
      tileMode: ui.TileMode.decal,
    );
  }

  void beginPostProcessing(ui.Canvas canvas, ui.Size size) {
    canvas.saveLayer(
      ui.Rect.fromLTWH(0, 0, size.width, size.height),
      ui.Paint()..imageFilter = _bloomEffect,
    );
  }

  void endPostProcessing(ui.Canvas canvas) {
    canvas.restore();
  }
}
