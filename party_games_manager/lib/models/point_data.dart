import 'dart:ui';

class PointData {
  Paint paint;
  Offset point;

  PointData({required this.paint, required this.point});

  Map<String, dynamic> toJson() {
    return {
      'point': {'dx': '${point.dx}', 'dy': '${point.dy}'}
    };
  }
}
