// lib/presentation/app.dart
import 'package:flutter/material.dart';
//import '../presentation/pages/loka_page.dart';
import 'package:triloka_rpg/presentation/pages/loka_3d_page.dart';

class LokaApp extends StatelessWidget {
  const LokaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loka Visualization',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LokaPage(),
    );
  }
}
