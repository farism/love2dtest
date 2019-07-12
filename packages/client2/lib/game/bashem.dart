import 'dart:ui';

import 'package:flutter/widgets.dart';

import './camera.dart';
import './renderers/debug_world.dart';
import '../ecs/manager.dart';
import '../ui/widgets.dart';

const double WORLD_WIDTH = 10.0;
const double WORLD_HEIGHT = WORLD_WIDTH * 9 / 16;

class BashEm extends RenderLoopCallbacks {
  Manager manager;
  Camera camera;

  BashEm() {
    manager = Manager(
      systems: [],
      renderers: [DebugWorld(manager, camera)],
    );
  }

  @override
  void lifecycleChange(AppLifecycleState state) {}

  @override
  void render(Canvas canvas) {}

  @override
  void resize(Size size) {}

  @override
  void update(double dt) {}
}
