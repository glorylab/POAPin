import 'dart:math';
import 'dart:ui';

class ShapePath {
  ShapePath.star({
    this.n = 5,
    this.outRadius = 100,
    this.innerRadius = 90,
  });

  ShapePath.polygon({
    this.n = 5,
    this.outRadius = 100,
  }) : innerRadius = null;

  final int n;
  final double outRadius;
  final double? innerRadius;
  Path? _path;

  Path get path {
    if (_path == null) {
      _buildPath();
    }
    return _path!;
  }

  void _buildPath() {
    int count = n;
    double offset = pi / count;
    List<Offset> points = [];
    double rotate = -pi / 2;
    for (int i = 0; i < count; i++) {
      double perRad = 2 * pi / count * i;
      points.add(Offset(
        outRadius * cos(perRad + rotate),
        outRadius * sin(perRad + rotate),
      ));
      if (innerRadius != null) {
        points.add(Offset(
          innerRadius! * cos(perRad + rotate + offset),
          innerRadius! * sin(perRad + rotate + offset),
        ));
      }
    }

    _path = Path();
    _path!.moveTo(points[0].dx + outRadius, points[0].dy + outRadius);

    for (int i = 1; i < points.length; i++) {
      _path!.lineTo(points[i].dx + outRadius, points[i].dy + outRadius);
    }
    _path!.close();
  }
}
