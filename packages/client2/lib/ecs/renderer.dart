import 'dart:ui';

import './entity_tracker.dart';
import './manager.dart';

abstract class IRenderer {
  int flag;
  String id;
}

abstract class Renderer extends EntityTracker implements IRenderer {
  Renderer(Manager manager) : super(manager);

  void render(Canvas canvas) {}
}
