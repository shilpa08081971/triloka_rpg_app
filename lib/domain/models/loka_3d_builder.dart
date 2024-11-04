// lib/domain/models/loka_3d_builder.dart
import 'package:flutter/material.dart';
import 'package:triloka_rpg/domain/models/loka_path.dart';
import 'package:triloka_rpg/domain/models/mesh_3d.dart';

class Loka3DBuilder {
  static Mesh3D createLokaMesh() {
    final paths = _createLokaPaths();
    return Mesh3D.fromLokaPaths(paths);
  }

  static List<LokaPath> _createLokaPaths() {
    return [
      // Layer 1 Copy (Top front)
      LokaPath(
        path: _createUpperLokaPath(),
        fillColor: const Color.fromARGB(255, 48, 226, 25),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'layer1_copy',
        depth: 50,
      ),

      // 2D Loka Duplicated Back (Upper back)
      LokaPath(
        path: _createUpperBackPath(),
        fillColor: const Color.fromARGB(255, 61, 157, 67),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'duplicated_back',
        depth: 30,
      ),

      // Bottom Connect Plane
      LokaPath(
        path: _createBottomConnectPath(),
        fillColor: const Color.fromARGB(255, 226, 25, 25),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'bottom_connect',
        depth: 20,
      ),

      // Middle Connect Plane
      LokaPath(
        path: _createMiddleConnectPath(),
        fillColor: const Color.fromARGB(255, 226, 25, 25),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'middle_connect',
        depth: 10,
      ),

      // Upper Middle Connect
      LokaPath(
        path: _createUpperMiddleConnectPath(),
        fillColor: const Color.fromARGB(255, 194, 45, 45),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'upper_middle_connect',
      ),

      // Upper Connect Plane
      LokaPath(
        path: _createUpperConnectPath(),
        fillColor: const Color.fromARGB(255, 226, 25, 25),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'upper_connect',
        depth: -10,
      ),

      // Original Layer (Base)
      LokaPath(
        path: _createOriginalPath(),
        fillColor: const Color.fromARGB(255, 10, 198, 204),
        strokeColor: const Color.fromARGB(255, 33, 150, 243),
        name: 'original',
        depth: -20,
      ),
    ];
  }

  static Path _createUpperLokaPath() {
    return Path()
      ..moveTo(200, 100)
      ..lineTo(650, 0)
      ..lineTo(750, 175)
      ..lineTo(650, 350)
      ..lineTo(800, 700)
      ..lineTo(350, 800)
      ..lineTo(200, 450)
      ..lineTo(300, 275);
  }

  static Path _createUpperBackPath() {
    return Path()
      ..moveTo(650, 0)
      ..lineTo(750, 175)
      ..lineTo(650, 350)
      ..lineTo(800, 700)
      ..lineTo(450, 700)
      ..lineTo(600, 350)
      ..lineTo(500, 175)
      ..lineTo(600, 0);
  }

  static Path _createBottomConnectPath() {
    return Path()
      ..moveTo(350, 800)
      ..lineTo(800, 700)
      ..lineTo(450, 700)
      ..lineTo(0, 800);
  }

  static Path _createMiddleConnectPath() {
    return Path()
      ..moveTo(200, 450)
      ..lineTo(650, 350)
      ..lineTo(600, 350)
      ..lineTo(150, 450);
  }

  static Path _createUpperMiddleConnectPath() {
    return Path()
      ..moveTo(750, 175)
      ..lineTo(500, 175)
      ..lineTo(50, 275)
      ..lineTo(300, 275);
  }

  static Path _createUpperConnectPath() {
    return Path()
      ..moveTo(150, 100)
      ..lineTo(600, 0)
      ..lineTo(650, 0)
      ..lineTo(200, 100);
  }

  static Path _createOriginalPath() {
    return Path()
      ..moveTo(200, 100)
      ..lineTo(300, 275)
      ..lineTo(200, 450)
      ..lineTo(350, 800)
      ..lineTo(0, 800)
      ..lineTo(150, 450)
      ..lineTo(50, 275)
      ..lineTo(150, 100);
  }
}
