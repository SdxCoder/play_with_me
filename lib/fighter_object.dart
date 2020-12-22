import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Fighter extends CustomPainter {
  final Color skinColor;

  Fighter({this.skinColor}) : assert(skinColor != null);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(232, 43, 135, 227)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    if (skinColor == Colors.transparent) {
      paint_0.shader = ui.Gradient.linear(
          Offset(size.width * 0.50, 0),
          Offset(size.width * 0.50, size.height * 0.80),
          [Color(0xfc2f27d3), Color(0xff000000), Color(0xd1ffffff)],
          [0.00, 1.00, 1.00]);
    }else{
      paint_0.color = skinColor;
    }

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.50, 0);
    path_0.quadraticBezierTo(size.width * 0.42, size.height * 0.15,
        size.width * 0.40, size.height * 0.20);
    path_0.quadraticBezierTo(size.width * 0.30, size.height * 0.30,
        size.width * 0.05, size.height * 0.32);
    path_0.lineTo(0, size.height * 0.40);
    path_0.quadraticBezierTo(size.width * 0.30, size.height * 0.40,
        size.width * 0.30, size.height * 0.40);
    path_0.cubicTo(size.width * 0.40, size.height * 0.45, size.width * 0.38,
        size.height * 0.55, size.width * 0.35, size.height * 0.60);
    path_0.quadraticBezierTo(size.width * 0.35, size.height * 0.65,
        size.width * 0.25, size.height * 0.80);
    path_0.lineTo(size.width * 0.75, size.height * 0.80);
    path_0.quadraticBezierTo(size.width * 0.65, size.height * 0.65,
        size.width * 0.65, size.height * 0.60);
    path_0.cubicTo(size.width * 0.63, size.height * 0.55, size.width * 0.60,
        size.height * 0.45, size.width * 0.70, size.height * 0.40);
    path_0.quadraticBezierTo(
        size.width * 0.70, size.height * 0.40, size.width, size.height * 0.40);
    path_0.lineTo(size.width * 0.98, size.height * 0.32);
    path_0.quadraticBezierTo(size.width * 0.70, size.height * 0.30,
        size.width * 0.60, size.height * 0.20);
    path_0.quadraticBezierTo(
        size.width * 0.57, size.height * 0.15, size.width * 0.50, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_1.shader = ui.Gradient.linear(
        Offset(size.width * 0.53, size.height * 0.80),
        Offset(size.width * 0.53, size.height * 0.96),
        [Color(0xffbe8531), Color(0xffbe472b), Color(0xffbf1d1d)],
        [0.00, 0.91, 1.00]);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.40, size.height * 0.80);
    path_1.lineTo(size.width * 0.32, size.height * 0.96);
    path_1.lineTo(size.width * 0.43, size.height * 0.84);
    path_1.lineTo(size.width * 0.43, size.height * 0.96);
    path_1.lineTo(size.width * 0.49, size.height * 0.84);
    path_1.lineTo(size.width * 0.53, size.height * 0.96);
    path_1.lineTo(size.width * 0.55, size.height * 0.84);
    path_1.lineTo(size.width * 0.63, size.height * 0.96);
    path_1.lineTo(size.width * 0.61, size.height * 0.84);
    path_1.lineTo(size.width * 0.73, size.height * 0.96);
    path_1.lineTo(size.width * 0.70, size.height * 0.90);
    path_1.lineTo(size.width * 0.64, size.height * 0.80);
    path_1.lineTo(size.width * 0.40, size.height * 0.80);
    path_1.close();

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
