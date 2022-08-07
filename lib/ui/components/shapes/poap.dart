import 'package:flutter/material.dart';
import 'package:poapin/ui/components/shapes/shape_path.dart';

class POAPShapeBorder extends ShapeBorder {
  POAPShapeBorder();

  final Paint shapePaint = Paint()..style = PaintingStyle.stroke;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return ShapePath.star(
      n: 12,
      outRadius: rect.width / 2,
      innerRadius: rect.width / 2.2,
    ).path;
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
