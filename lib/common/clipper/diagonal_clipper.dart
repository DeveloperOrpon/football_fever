import 'package:flutter/material.dart';

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double heightFactor = 0.67;

    Path path = Path();
    path.moveTo(0, size.height * heightFactor);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * (1 - heightFactor));
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
