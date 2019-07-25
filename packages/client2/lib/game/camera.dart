import 'dart:ui';

import 'package:box2d_flame/box2d.dart';

class Camera extends ViewportTransform {
  Size size;
  double scale;

  Camera(this.size, this.scale)
      : super(
          Vector2(size.width / 2, size.height / 2),
          Vector2(size.width / 2, size.height / 2),
          scale,
        );

  void resize(Size size) {
    this.size = size;
    extents = Vector2(size.width / 2, size.height / 2);
    center = Vector2(size.width / 2, size.height / 2);
  }

  Vector2 project(Body body, Vector2 point) {
    final out = body.getWorldPoint(point.clone());
    getWorldToScreen(out, out);

    return out;
  }
}
