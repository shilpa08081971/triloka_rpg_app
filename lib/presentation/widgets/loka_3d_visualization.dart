// lib/presentation/widgets/loka_3d_visualization.dart

import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:triloka_rpg/domain/models/mesh_3d.dart';
import 'package:triloka_rpg/domain/models/render_state.dart';
import 'package:triloka_rpg/domain/models/transform_3d.dart';
import 'package:triloka_rpg/presentation/painters/enhanced_3d_painter.dart';
import 'package:triloka_rpg/presentation/widgets/value_listenable_builder2.dart';
import 'package:triloka_rpg/utils/loka_3d_builder.dart';

class Loka3DVisualization extends StatefulWidget {
  const Loka3DVisualization({super.key});

  @override
  State<Loka3DVisualization> createState() => _Loka3DVisualizationState();
}

class _Loka3DVisualizationState extends State<Loka3DVisualization>
    with SingleTickerProviderStateMixin {
  static const double _rotationSensitivity = 0.01;
  static const double _scaleMin = 0.5;
  static const double _scaleMax = 2;

  late final AnimationController _controller;
  late final ValueNotifier<Transform3D> _transformNotifier;
  late final ValueNotifier<RenderState> _renderStateNotifier;
  late final Mesh3D _lokaMesh;

  Offset? _lastFocalPoint;
  double _lastScale = 1;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _lokaMesh = Loka3DBuilder.createLokaMesh();
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
              painter: Enhanced3DPainter(
                transform: transform,
                renderState: renderState,
                mesh: _lokaMesh,
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
