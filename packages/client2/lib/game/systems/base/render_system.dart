import 'dart:ui';

import './system.dart';

abstract class RenderSystem extends BaseSystem {
  void render(Canvas canvas);
}
