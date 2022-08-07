import 'dart:math';

import 'package:flutter/material.dart';

class CalenderDayShapeBorder extends ShapeBorder {
  final int holeCount;
  final double lineRate;
  final double leftWidth;
  final bool dash;
  final Color color;

  const CalenderDayShapeBorder(
      {this.holeCount = 6,
      this.lineRate = 0.718,
      this.leftWidth = 88,
      this.dash = false,
      this.color = Colors.white});

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    var w = rect.width;
    var h = rect.height;

    var d = h / (1 + 2 * holeCount);

    var path = Path();
    path.addRect(rect);

    _formHoldLeft(path, d);
    _formHoldRight(path, w, d);
    _formHoleTop(path, rect);
    _formHoleBottom(path, rect);
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  void _formHoleBottom(Path path, Rect rect) {
    path.addArc(
        Rect.fromCenter(
            center: Offset(leftWidth, rect.height), width: 13.0, height: 13.0),
        pi,
        pi);
  }

  void _formHoleTop(Path path, Rect rect) {
    path.addArc(
        Rect.fromCenter(
            center: Offset(leftWidth, 0), width: 13.0, height: 13.0),
        0,
        pi);
  }

  _formHoldLeft(Path path, double d) {
    for (int i = 0; i < holeCount; i++) {
      var left = -d / 2;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), -pi / 2, pi);
    }
  }

  _formHoldRight(Path path, double w, double d) {
    for (int i = 0; i < holeCount; i++) {
      var left = -d / 2 + w;
      var top = 0.0 + d + 2 * d * (i);
      var right = left + d;
      var bottom = top + d;
      path.addArc(Rect.fromLTRB(left, top, right, bottom), pi / 2, pi);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    var d = rect.height / (1 + 2 * holeCount);
    if (dash) {
      _drawDashLine(canvas, Offset(leftWidth, d / 2), rect.height / 16,
          rect.height - 13, paint);
    }
  }

  _drawDashLine(
      Canvas canvas, Offset start, double count, double length, Paint paint) {
    var step = length / count / 2;
    for (int i = 0; i < count; i++) {
      var offset = start + Offset(0, 2 * step * i);
      canvas.drawLine(offset, offset + Offset(0, step), paint);
    }
  }

  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }
}
