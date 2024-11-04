// lib/domain/models/transform_3d.dart
// import 'dart:ui';

import 'package:flutter/rendering.dart';
// import 'dart:math' show pi;

class Transform3D {

  const Transform3D({
    this.translateX = 0,
    this.translateY = 0,
    this.rotateX = 0,
    this.rotateY = 0,
    this.rotateZ = 0,
    this.scale = 1.0,
  });
  final double translateX;
  final double translateY;
  final double rotateX;
  final double rotateY;
  final double rotateZ;
  final double scale;

  Transform3D copyWith({
    double? translateX,
    double? translateY,
    double? rotateX,
    double? rotateY,
    double? rotateZ,
    double? scale,
  }) {
    return Transform3D(
      translateX: translateX ?? this.translateX,
      translateY: translateY ?? this.translateY,
      rotateX: rotateX ?? this.rotateX,
      rotateY: rotateY ?? this.rotateY,
      rotateZ: rotateZ ?? this.rotateZ,
      scale: scale ?? this.scale,
    );
  }

  Matrix4 asMatrix4() {
    return Matrix4.identity()
      ..translate(translateX, translateY)
      ..rotateX(rotateX)
      ..rotateY(rotateY)
      ..rotateZ(rotateZ)
      ..scale(scale);
  }
}
