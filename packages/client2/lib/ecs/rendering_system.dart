import 'dart:ui';

import './manager.dart';
import './system.dart';

abstract class RenderingSystem extends System {
  RenderingSystem(Manager manager) : super(manager);

  SystemType getSystemType() => SystemType.rendering;

  void render(Canvas canvas);
}
