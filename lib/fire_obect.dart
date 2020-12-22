import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FireObject extends CustomPainter {
  
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(
        Offset(size.width * 0.50, 0), Offset(size.width * 0.50, size.height), [
      Color(0xfffff700),
      Color(0xfff30c0c),
      Color(0xffffbc00),
      Color(0xfff90000),
      Color(0xff000000),
      Color(0xffffffff)
    ], [
      0.00,
      0.19,
      0.53,
      0.99,
      0.99,
      1.00
    ]);

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.50, 0);
    path_0.quadraticBezierTo(
        size.width * 0.20, size.height * 0.01, 0, size.height * 0.40);
    path_0.quadraticBezierTo(
        size.width * 0.40, size.height * 0.70, size.width * 0.50, size.height);
    path_0.quadraticBezierTo(
        size.width * 0.60, size.height * 0.70, size.width, size.height * 0.40);
    path_0.quadraticBezierTo(
        size.width * 0.79, size.height * 0.01, size.width * 0.50, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
