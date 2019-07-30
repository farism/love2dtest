import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flutter/widgets.dart';

import './box2d.dart';
import './camera.dart';
import './entity_factory.dart';
import './systems/base/collision_system.dart';
import './systems/base/input_system.dart';
import './systems/base/render_system.dart';
import './systems/base/system.dart';
import './systems/systems.dart';
import '../ecs/manager.dart';
import '../ui/gesture_widget.dart';
import '../ui/render_loop.dart';

const double WORLD_WIDTH = 10.0;
const double WORLD_HEIGHT = WORLD_WIDTH * 9 / 16;

class Game implements ContactListener, GestureListener, RenderLoopListener {
  EntityFactory entityFactory;
  Manager manager;
  Camera camera;
  World world;
  List<BaseSystem> processSystems = [];
  List<CollisionSystem> collisionSystems = [];
  List<InputSystem> inputSystems = [];
  List<RenderSystem> renderSystems = [];

  Game() {
    initialize();
  }

  void initialize() {
    camera = Camera(window.physicalSize, 32);

    world = World.withGravity(Vector2(0, 0))..setContactListener(this);

    inputSystems.addAll([
      InputDrag(),
    ]);

    collisionSystems.addAll([
      CollisionDamage(),
    ]);

    processSystems.addAll([
      ProcessSyncPosition(camera),
      ProcessAttack(),
    ]);

    renderSystems.addAll([
      RenderDebugWorld(camera),
      RenderAttackTrajectory(camera),
      RenderHealth(camera),
    ]);

    manager = Manager()
      ..addSystems(inputSystems)
      ..addSystems(collisionSystems)
      ..addSystems(processSystems)
      ..addSystems(renderSystems);

    entityFactory = EntityFactory(manager, world);
    entityFactory.map();
    entityFactory.userPlayer(0, 3);
    entityFactory.enemyPlayer(2, -3);
  }

  // render loop callbacks

  @override
  void lifecycleChange(AppLifecycleState state) {}

  @override
  void render(Canvas canvas) {
    renderSystems.forEach((system) => system.render(canvas));
  }

  @override
  void resize(Size size) {
    camera.resize(size);
  }

  @override
  void update(double dt) {
    world.stepDt(dt, 10, 10);
    manager.update(dt);
  }

  // world collision callbacks

  ContactResult getContactResultHelper(Contact contact) {
    return getContactResult((userData) => userData['entity'], contact);
  }

  @override
  void beginContact(Contact contact) {
    final result = getContactResultHelper(contact);

    collisionSystems.forEach((system) => system.beginContact(result));
  }

  @override
  void endContact(Contact contact) {
    final result = getContactResultHelper(contact);

    collisionSystems.forEach((system) => system.endContact(result));
  }

  @override
  void preSolve(Contact contact, Manifold oldManifold) {
    final result = getContactResultHelper(contact);

    collisionSystems.forEach((system) => system.preSolve(result, oldManifold));
  }

  @override
  void postSolve(Contact contact, ContactImpulse impulse) {
    final result = getContactResultHelper(contact);

    collisionSystems.forEach((system) => system.postSolve(result, impulse));
  }

  // gesture callbacks

  @override
  void gesture(GestureType type, [dynamic details]) {
    inputSystems.forEach((system) => system.gesture(type, details));
  }
}

// class TimedGame extends Game {
//   @override
//   initialize() {
//     super.initialize();
//   }
// }
