import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:client2/game/entity_factory.dart';
import 'package:client2/game/systems/process_death.dart';
import 'package:flutter/widgets.dart';

import './camera.dart';
import './systems/render_debug_world.dart';
import '../ecs/manager.dart';
import '../ui/widgets.dart';

const double WORLD_WIDTH = 10.0;
const double WORLD_HEIGHT = WORLD_WIDTH * 9 / 16;

class Game extends RenderLoopCallbacks {
  EntityFactory entityFactory;
  Manager manager;
  Camera camera;
  World world;

  Game() {
    camera = Camera(window.physicalSize, 1.0);

    world = World.withGravity(Vector2(0, 0));

    manager = Manager(
      systems: [
        // rendering
        RenderDebugWorld(manager, camera),

        // collision handling

        // processing
        ProcessDeath(manager),
      ],
    );

    entityFactory = EntityFactory(manager, world);
    entityFactory.player();
  }

  @override
  void lifecycleChange(AppLifecycleState state) {}

  @override
  void render(Canvas canvas) {
    manager.render(canvas);
  }

  @override
  void resize(Size size) {
    camera.resize(size);
  }

  @override
  void update(double dt) {
    manager.update(dt);
  }
}
