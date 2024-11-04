// lib/domain/models/mesh_3d.dart
// import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:triloka_rpg/domain/models/loka_path.dart';
import 'package:vector_math/vector_math_64.dart';

class Point3D {
  
  const Point3D(this.x, this.y, this.z);
  final double x;
  final double y;
  final double z;
  
  Point3D transformed(Matrix4 matrix) {
    final result = matrix.transformed3(Vector3(x, y, z));
    return Point3D(result.x, result.y, result.z);
  }
}

class Face3D {

  const Face3D({
    required this.indices,
    required this.color,
    this.normalZ = 0,
  });
  final List<int> indices;
  final Color color;
  final double normalZ;
}

class Mesh3D {
  
  const Mesh3D({
    required this.vertices,
    required this.faces,
  });

  factory Mesh3D.fromLokaPaths(List<LokaPath> paths) {
    final vertices = <Point3D>[];
    final faces = <Face3D>[];
    var vertexOffset = 0;

    for (final path in paths) {
      final pathVertices = _extractVerticesFromPath(path.path);
      vertices.addAll([
        // Front face vertices
        for (final point in pathVertices)
          Point3D(point.dx, point.dy, path.depth),
        // Back face vertices
        for (final point in pathVertices)
          Point3D(point.dx, point.dy, path.depth - 20), // Depth thickness
      ]);

      // Create faces for this path section
      final numPoints = pathVertices.length;
      
      // Front face
      faces..add(Face3D(
        indices: List.generate(numPoints, (i) => vertexOffset + i),
        color: path.fillColor,
      ),)

      // Back face
      ..add(Face3D(
        indices: List.generate
        (numPoints, (i) => vertexOffset + numPoints + i).reversed.toList(),
        color: path.fillColor.withOpacity(0.8),
      ),);

      // Side faces
      for (var i = 0; i < numPoints; i++) {
        final nextI = (i + 1) % numPoints;
        faces.add(Face3D(
          indices: [
            vertexOffset + i,
            vertexOffset + nextI,
            vertexOffset + numPoints + nextI,
            vertexOffset + numPoints + i,
          ],
          color: path.fillColor.withOpacity(0.9),
        ),);
      }

      vertexOffset += numPoints * 2;
    }

    return Mesh3D(vertices: vertices, faces: faces);
  }
  final List<Point3D> vertices;
  final List<Face3D> faces;

  static List<Offset> _extractVerticesFromPath(Path path) {
    final points = <Offset>[];
    final metrics = path.computeMetrics();
    
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position;
        if (pos != null) points.add(pos);
        distance += metric.length / 20; // Adjust for vertex density
      }
    }
    
    return points;
  }
}
