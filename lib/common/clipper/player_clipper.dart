import 'package:flutter/material.dart';

class PlayerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width - size.width * 0.22000, 0);
    path_0.lineTo(0, 0);
    path_0.lineTo(0, size.height);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
