// Created by Vishwa on 15/11/22.
// Project Name diamond_bag_tracking.
import 'package:flutter/material.dart';

class AppBarCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color(0xFFE5E5E4)
      ..style = PaintingStyle.fill;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0001500, size.height * 0.9963000);
    path0.lineTo(size.width * 0.1222000, size.height * 0.0024000);
    path0.lineTo(size.width, size.height * 0.0052000);
    path0.lineTo(size.width, size.height * 0.9939000);
    path0.lineTo(size.width * 0.0001500, size.height * 0.9963000);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
