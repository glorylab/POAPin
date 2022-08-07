import 'package:flutter/material.dart';
import 'package:poapin/ui/components/shapes/shape_path.dart';

class SettingShapeBorder extends ShapeBorder {
  SettingShapeBorder();

  final Paint shapePaint = Paint()..style = PaintingStyle.stroke;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return ShapePath.polygon(
      n: 6,
      outRadius: rect.width / 2,
    ).path;
  }

  void rotate(
      {required Canvas canvas,
      required double cx,
      required double cy,
      required double angle}) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

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
