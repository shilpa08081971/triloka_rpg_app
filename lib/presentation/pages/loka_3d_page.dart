// lib/presentation/pages/loka_3d_page.dart
import 'package:flutter/material.dart';
import 'package:triloka_rpg/presentation/widgets/loka_3d_visualization.dart';

class LokaPage extends StatelessWidget {
  const LokaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loka 3D Visualization')),
      body: const Center(child: Loka3DVisualization()),
    );
  }
}
