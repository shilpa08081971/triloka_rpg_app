// lib/presentation/widgets/loka_visualization.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:triloka_rpg/domain/models/render_state.dart';
import 'package:triloka_rpg/domain/models/transform_3d.dart';
import 'package:triloka_rpg/presentation/painters/enhanced_loka_painter.dart';
import 'package:triloka_rpg/presentation/widgets/value_listenable_builder2.dart';

class LokaVisualization extends StatefulWidget {
  const LokaVisualization({super.key});

  @override
  State<LokaVisualization> createState() => _LokaVisualizationState();
}

class _LokaVisualizationState extends State<LokaVisualization>
    with SingleTickerProviderStateMixin {
  static const double _rotationSensitivity = 0.01;
  static const double _scaleMin = 0.5;
  static const double _scaleMax = 2;

  late final AnimationController _controller;
  late final ValueNotifier<Transform3D> _transformNotifier;
  late final ValueNotifier<RenderState> _renderStateNotifier;

  Offset? _lastFocalPoint;
  double _lastScale = 1;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..addListener(_updateAnimation);

    _transformNotifier = ValueNotifier(const Transform3D());
    _renderStateNotifier = ValueNotifier(const RenderState());

    _controller.repeat();
  }

  void _updateAnimation() {
    final currentTransform = _transformNotifier.value;
    _transformNotifier.value = currentTransform.copyWith(
      rotateZ: _controller.value * 2 * pi,
    );
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _controller.stop();
    _lastFocalPoint = details.focalPoint;
    _lastScale = _transformNotifier.value.scale;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (_lastFocalPoint == null) return;

    final delta = details.focalPoint - _lastFocalPoint!;
    final currentTransform = _transformNotifier.value;

    _transformNotifier.value = currentTransform.copyWith(
      rotateY: details.pointerCount == 1
          ? currentTransform.rotateY + delta.dx * _rotationSensitivity
          : currentTransform.rotateY,
      rotateX: details.pointerCount == 1
          ? currentTransform.rotateX + delta.dy * _rotationSensitivity
          : currentTransform.rotateX,
      scale: (_lastScale * details.scale).clamp(_scaleMin, _scaleMax),
    );

    _lastFocalPoint = details.focalPoint;
  }

  void _handleScaleEnd(ScaleEndDetails details) {
    _lastFocalPoint = null;
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      onScaleEnd: _handleScaleEnd,
      child: ValueListenableBuilder2<Transform3D, RenderState>(
        first: _transformNotifier,
        second: _renderStateNotifier,
        builder: (context, transform, renderState, _) {
          return RepaintBoundary(
            child: CustomPaint(
              size: const Size(800, 800),
              painter: EnhancedLokaPainter(
                transform: transform,
                renderState: renderState,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _transformNotifier.dispose();
    _renderStateNotifier.dispose();
    super.dispose();
  }
}
