import 'dart:ui';

import '../rendering/camera.dart';
import './entity_tracker.dart';

abstract class IRenderer {
  int flag;
  String id;
}

abstract class Renderer extends EntityTracker implements IRenderer {
  void render(Canvas canvas, Camera camera) {}
}
