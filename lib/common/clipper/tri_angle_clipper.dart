import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, 3); // start with bottom-left corner
    path.lineTo(size.width / 2, 0.0); // move to top-center
    path.close(); // close the path to form a triangle
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
