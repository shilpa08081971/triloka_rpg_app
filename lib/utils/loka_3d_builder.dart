// lib/domain/models/loka_3d_builder.dart
import 'package:flutter/material.dart';
// import 'package:triloka_rpg/domain/models/loka_path.dart';
import 'package:triloka_rpg/domain/models/mesh_3d.dart';

class Loka3DBuilder {
  static const double rAJJU = 100; // Base unit for scaling
  
  static Mesh3D createLokaMesh() {
    final vertices = <Point3D>[
      // Upper Most plane (1 rAJJU wide)
      const Point3D(-0.5 * rAJJU, -7 * rAJJU, -3.5 * rAJJU),  // Front left
      const Point3D(0.5 * rAJJU, -7 * rAJJU, -3.5 * rAJJU),   // Front right
      const Point3D(-0.5 * rAJJU, -7 * rAJJU, 3.5 * rAJJU),   // Back left
      const Point3D(0.5 * rAJJU, -7 * rAJJU, 3.5 * rAJJU),    // Back right

      // Upper Middle plane (5 rAJJU wide)
      const Point3D(-2.5 * rAJJU, -3.5 * rAJJU, -3.5 * rAJJU), // Front left
      const Point3D(2.5 * rAJJU, -3.5 * rAJJU, -3.5 * rAJJU),  // Front right
      const Point3D(-2.5 * rAJJU, -3.5 * rAJJU, 3.5 * rAJJU),  // Back left
      const Point3D(2.5 * rAJJU, -3.5 * rAJJU, 3.5 * rAJJU),   // Back right

      // Middle plane (1 rAJJU wide)
      const Point3D(-0.5 * rAJJU, 0, -3.5 * rAJJU),  // Front left
      const Point3D(0.5 * rAJJU, 0, -3.5 * rAJJU),   // Front right
      const Point3D(-0.5 * rAJJU, 0, 3.5 * rAJJU),   // Back left
      const Point3D(0.5 * rAJJU, 0, 3.5 * rAJJU),    // Back right

      // Lower plane (7 rAJJU wide)
      const Point3D(-3.5 * rAJJU, 7 * rAJJU, -3.5 * rAJJU),  // Front left
      const Point3D(3.5 * rAJJU, 7 * rAJJU, -3.5 * rAJJU),   // Front right
      const Point3D(-3.5 * rAJJU, 7 * rAJJU, 3.5 * rAJJU),   // Back left
      const Point3D(3.5 * rAJJU, 7 * rAJJU, 3.5 * rAJJU),    // Back right
    ];

    final faces = <Face3D>[
      // Upper Most plane faces
      const Face3D(indices: [0, 1, 3, 2], 
      color: Color.fromARGB(255, 48, 226, 25),),
      
      // Upper Middle plane faces
      const Face3D(indices: [4, 5, 7, 6], 
      color: Color.fromARGB(255, 61, 157, 67),),
      
      // Middle plane faces
      const Face3D(indices: [8, 9, 11, 10], 
      color: Color.fromARGB(255, 226, 25, 25),),
      
      // Lower plane faces
      const Face3D(indices: [12, 13, 15, 14], 
      color: Color.fromARGB(255, 10, 198, 204),),
      
      // Front connecting faces
      const Face3D(indices: [0, 4, 5, 1], 
      color: Color.fromARGB(255, 226, 25, 25),),
      const Face3D(indices: [4, 8, 9, 5], 
      color: Color.fromARGB(255, 194, 45, 45),),
      const Face3D(indices: [8, 12, 13, 9], 
      color: Color.fromARGB(255, 226, 25, 25),),
      
      // Back connecting faces
      const Face3D(indices: [2, 6, 7, 3], 
      color: Color.fromARGB(255, 226, 25, 25),),
      const Face3D(indices: [6, 10, 11, 7], 
      color: Color.fromARGB(255, 194, 45, 45),),
      const Face3D(indices: [10, 14, 15, 11], 
      color: Color.fromARGB(255, 226, 25, 25),),
      
  // Left side connecting faces
  const Face3D(indices: [0, 2, 6, 4],
   color: Color.fromARGB(255, 226, 25, 25),),
  const Face3D(indices: [4, 6, 10, 8],
   color: Color.fromARGB(255, 226, 25, 25),),
  const Face3D(indices: [8, 10, 14, 12],
   color: Color.fromARGB(255, 226, 25, 25),),
  
  // Right side connecting faces
  const Face3D(indices: [1, 3, 7, 5],
   color: Color.fromARGB(255, 226, 25, 25),),
  const Face3D(indices: [5, 7, 11, 9],
   color: Color.fromARGB(255, 226, 25, 25),),
  const Face3D(indices: [9, 11, 15, 13],
   color: Color.fromARGB(255, 226, 25, 25),),
    ];

    return Mesh3D(vertices: vertices, faces: faces);
  }
}
