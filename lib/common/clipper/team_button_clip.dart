import 'package:flutter/material.dart';

class TeamButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0527500, size.height * 0.5987833);
    path_0.quadraticBezierTo(size.width * 0.0739500, size.height * 0.6916500,
        size.width * 0.5000000, size.height * 0.9983333);
    path_0.lineTo(size.width * 1.0050000, size.height);
    path_0.lineTo(size.width * 0.9950000, size.height * 0.0016667);
    path_0.quadraticBezierTo(size.width * 0.2565500, size.height * 0.1974167,
        size.width * 0.1125000, size.height * 0.3143667);
    path_0.cubicTo(
        size.width * -0.0011000,
        size.height * 0.3755667,
        size.width * -0.0201500,
        size.height * 0.5376667,
        size.width * 0.0527500,
        size.height * 0.5987833);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
