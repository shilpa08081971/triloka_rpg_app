// lib/main.dart
import 'package:flutter/material.dart';
import 'package:triloka_rpg/presentation/app.dart';

void main() {
  runApp(const LokaApp());
}

// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// void main() {
//   runApp(const LokaApp());
// }

// class LokaApp extends StatelessWidget {
//   const LokaApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Loka Visualization',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const LokaHomePage(),
//     );
//   }
// }

// class LokaHomePage extends StatelessWidget {
//   const LokaHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Loka Visualization')),
//       body: const Center(child: LokaVisualization()),
//     );
//   }
// }

// class LokaVisualization extends StatefulWidget {
//   const LokaVisualization({Key? key}) : super(key: key);

//   @override
//   State<LokaVisualization> createState() => _LokaVisualizationState();
// }

// class _LokaVisualizationState extends State<LokaVisualization> 
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   final ValueNotifier<double> _scale = ValueNotifier(1.0);
//   final ValueNotifier<Offset> _rotation = ValueNotifier(Offset.zero);

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 10),
//       vsync: this,
//     )..repeat();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onScaleStart: (_) {
//         _controller.stop();
//       },
//       onScaleUpdate: (details) {
//         if (details.pointerCount == 1) {
//           _rotation.value += details.focalPointDelta * 0.01;
//         }
//         _scale.value = (_scale.value * details.scale).clamp(0.5, 2.0);
//       },
//       onScaleEnd: (_) {
//         _controller.repeat();
//       },
//       child: AnimatedBuilder(
//         animation: _controller,
//         builder: (context, _) {
//           return CustomPaint(
//             size: const Size(800, 800),
//             painter: RPSCustomPainter(
//               rotation: _rotation.value,
//               scale: _scale.value,
//               animationValue: _controller.value,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _scale.dispose();
//     _rotation.dispose();
//     super.dispose();
//   }
// }

// class RPSCustomPainter extends CustomPainter {
//   final Offset rotation;
//   final double scale;
//   final double animationValue;

//   RPSCustomPainter({
//     required this.rotation,
//     required this.scale,
//     required this.animationValue,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Center the drawing
//     canvas.translate(size.width / 2, size.height / 2);
    
//     // Apply transformations
//     canvas.scale(scale);
//     canvas.rotate(animationValue * 2 * math.pi);
//     canvas.translate(rotation.dx * 50, rotation.dy * 50);

//     // Layer 1 Copy
//     Paint paint_fill_0 = Paint()
//       ..color = const Color.fromARGB(255, 48, 226, 25)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_0 = Path();
//     path_0.moveTo(size.width * 0.2500000, size.height * 0.1250000);
//     path_0.lineTo(size.width * 0.8125000, 0);
//     path_0.lineTo(size.width * 0.9375000, size.height * 0.2187500);
//     path_0.lineTo(size.width * 0.8125000, size.height * 0.4375000);
//     path_0.lineTo(size.width, size.height * 0.8750000);
//     path_0.lineTo(size.width * 0.4375000, size.height);
//     path_0.lineTo(size.width * 0.2500000, size.height * 0.5625000);
//     path_0.lineTo(size.width * 0.3750000, size.height * 0.3437500);

//     canvas.drawPath(path_0, paint_fill_0);

//     Paint paint_stroke_0 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_0, paint_stroke_0);

//     // Layer 1
//     Paint paint_fill_1 = Paint()
//       ..color = const Color.fromARGB(255, 48, 226, 25)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_1 = Path();
//     path_1.moveTo(size.width * 0.2500000, size.height * 0.1250000);
//     path_1.lineTo(size.width * 0.8125000, 0);
//     path_1.lineTo(size.width * 0.9375000, size.height * 0.2187500);
//     path_1.lineTo(size.width * 0.8125000, size.height * 0.4375000);
//     path_1.lineTo(size.width, size.height * 0.8750000);
//     path_1.lineTo(size.width * 0.4375000, size.height);
//     path_1.lineTo(size.width * 0.2500000, size.height * 0.5625000);
//     path_1.lineTo(size.width * 0.3750000, size.height * 0.3437500);

//     canvas.drawPath(path_1, paint_fill_1);

//     Paint paint_stroke_1 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_1, paint_stroke_1);

//     // 2D Loka Duplicated Back
//     Paint paint_fill_2 = Paint()
//       ..color = const Color.fromARGB(255, 61, 157, 67)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_2 = Path();
//     path_2.moveTo(size.width * 0.8125000, 0);
//     path_2.lineTo(size.width * 0.9375000, size.height * 0.2187500);
//     path_2.lineTo(size.width * 0.8125000, size.height * 0.4375000);
//     path_2.lineTo(size.width, size.height * 0.8750000);
//     path_2.lineTo(size.width * 0.5625000, size.height * 0.8750000);
//     path_2.lineTo(size.width * 0.7500000, size.height * 0.4375000);
//     path_2.lineTo(size.width * 0.6250000, size.height * 0.2187500);
//     path_2.lineTo(size.width * 0.7500000, 0);

//     canvas.drawPath(path_2, paint_fill_2);

//     Paint paint_stroke_2 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_2, paint_stroke_2);

//     // BottomConnectPlaneLayer01
//     Paint paint_fill_3 = Paint()
//       ..color = const Color.fromARGB(255, 226, 25, 25)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_3 = Path();
//     path_3.moveTo(size.width * 0.4375000, size.height);
//     path_3.lineTo(size.width, size.height * 0.8750000);
//     path_3.lineTo(size.width * 0.5625000, size.height * 0.8750000);
//     path_3.lineTo(0, size.height);

//     canvas.drawPath(path_3, paint_fill_3);

//     Paint paint_stroke_3 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_3, paint_stroke_3);

//     // MiddleConnectPlaneLayer01
//     Paint paint_fill_4 = Paint()
//       ..color = const Color.fromARGB(255, 226, 25, 25)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_4 = Path();
//     path_4.moveTo(size.width * 0.2500000, size.height * 0.5625000);
//     path_4.lineTo(size.width * 0.8125000, size.height * 0.4375000);
//     path_4.lineTo(size.width * 0.7500000, size.height * 0.4375000);
//     path_4.lineTo(size.width * 0.1875000, size.height * 0.5625000);

//     canvas.drawPath(path_4, paint_fill_4);

//     Paint paint_stroke_4 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_4, paint_stroke_4);

//     // UpperMiddleConnectLayer01
//     Paint paint_fill_5 = Paint()
//       ..color = const Color.fromARGB(255, 194, 45, 45)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_5 = Path();
//     path_5.moveTo(size.width * 0.9375000, size.height * 0.2187500);
//     path_5.lineTo(size.width * 0.6250000, size.height * 0.2187500);
//     path_5.lineTo(size.width * 0.0625000, size.height * 0.3437500);
//     path_5.lineTo(size.width * 0.3750000, size.height * 0.3437500);

//     canvas.drawPath(path_5, paint_fill_5);

//     Paint paint_stroke_5 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_5, paint_stroke_5);

//     // UpperConnectPlaneLayer01
//     Paint paint_fill_6 = Paint()
//       ..color = const Color.fromARGB(255, 226, 25, 25)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_6 = Path();
//     path_6.moveTo(size.width * 0.1875000, size.height * 0.1250000);
//     path_6.lineTo(size.width * 0.7500000, 0);
//     path_6.lineTo(size.width * 0.8125000, 0);
//     path_6.lineTo(size.width * 0.2500000, size.height * 0.1250000);

//     canvas.drawPath(path_6, paint_fill_6);

//     Paint paint_stroke_6 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_6, paint_stroke_6);

//     // Loka 2D Layer Original
//     Paint paint_fill_8 = Paint()
//       ..color = const Color.fromARGB(255, 10, 198, 204)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     Path path_8 = Path();
//     path_8.moveTo(size.width * 0.2500000, size.height * 0.1250000);
//     path_8.lineTo(size.width * 0.3750000, size.height * 0.3437500);
//     path_8.lineTo(size.width * 0.2500000, size.height * 0.5625000);
//     path_8.lineTo(size.width * 0.4375000, size.height);
//     path_8.lineTo(0, size.height);
//     path_8.lineTo(size.width * 0.1875000, size.height * 0.5625000);
//     path_8.lineTo(size.width * 0.0625000, size.height * 0.3437500);
//     path_8.lineTo(size.width * 0.1875000, size.height * 0.1250000);

//     canvas.drawPath(path_8, paint_fill_8);

//     Paint paint_stroke_8 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width * 0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;

//     canvas.drawPath(path_8, paint_stroke_8);
//   }

//   @override
//   bool shouldRepaint(covariant RPSCustomPainter oldDelegate) {
//     return oldDelegate.rotation != rotation ||
//            oldDelegate.scale != scale ||
//            oldDelegate.animationValue != animationValue;
//   }
// }
