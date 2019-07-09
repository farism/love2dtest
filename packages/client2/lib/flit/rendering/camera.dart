import 'dart:ui';

import 'package:box2d_flame/box2d.dart';

class Camera extends ViewportTransform {
  Size size;

  @override
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

  // double get width => size.width / scale / window.devicePixelRatio;

  // double get height => size.height / scale / window.devicePixelRatio;
}
