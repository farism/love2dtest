import 'dart:ui';

import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';

class World extends Box2DComponent {
  World() : super(scale: 4.0);

  void initializeWorld() {}

  @override
  void update(t) {
    super.update(t);
  }

  void handleTap(Offset position) {
    print(position);
  }
}
