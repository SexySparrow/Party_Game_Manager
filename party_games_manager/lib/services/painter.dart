import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:party_games_manager/models/point_data.dart';

class Painter extends CustomPainter {
  List<Offset> offsetList = [];
  List<PointData> pointsList;
  Color selectedColor;

  Painter({required this.pointsList, required this.selectedColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint backGround = Paint();
    backGround.color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, backGround);
    canvas.clipRect(rect);

    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i].point.dx != -100 && pointsList[i + 1].point.dx != -100) {
        canvas.drawLine(pointsList[i].point, pointsList[i + 1].point, pointsList[i].paint);
      } else if (pointsList[i].point.dx != -100 && pointsList[i + 1].point.dx == -100) {
        canvas.drawPoints(PointMode.points, [pointsList[i].point], pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
