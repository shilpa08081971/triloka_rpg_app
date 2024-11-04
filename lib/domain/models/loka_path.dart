// lib/domain/models/loka_path.dart
import 'package:flutter/material.dart';

class LokaPath {

  const LokaPath({
    required this.path,
    required this.fillColor,
    required this.strokeColor,
    required this.name,
    this.depth = 0,
    this.normalScale = 1.0,
  });
  final Path path;
  final Color fillColor;
  final Color strokeColor;
  final String name;
  final double depth;
  final double normalScale;
}
