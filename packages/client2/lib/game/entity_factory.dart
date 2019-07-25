import 'package:box2d_flame/box2d.dart';

import '../ecs/ecs.dart';
import './components/damage.dart';
import './components/drag_input.dart';
import './components/game_object.dart';
import './components/health.dart';
import './components/position.dart' as pos;

class EntityFactory {
  Manager manager;
  World world;

  EntityFactory(this.manager, this.world);

  Body mapBody(List<Vector2> vertices) {
    final chain = ChainShape()..createLoop(vertices, vertices.length);

    final fixtureDef = FixtureDef()
      ..shape = chain
      ..friction = 1
      ..restitution = 1;

    final bodyDef = BodyDef()..type = BodyType.STATIC;

    return world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  Body playerBody(double x, double y) {
    final circle = CircleShape()..radius = 1;

    final fixtureDef = FixtureDef()
      ..shape = circle
      ..friction = 1
      ..density = 1
      ..restitution = 0.4;

    final bodyDef = BodyDef()
      ..position = Vector2(x, y)
      ..type = BodyType.DYNAMIC
      ..linearDamping = .99
      ..bullet = true;

    return world.createBody(bodyDef)..createFixtureFromFixtureDef(fixtureDef);
  }

  Entity userPlayer(double x, double y) {
    final entity = manager.createEntity('user');
    final body = playerBody(x, y);

    return entity
      ..addComponent(GameObject(body, entity))
      ..addComponent(DragInput())
      ..addComponent(Damage(hitpoints: 1))
      ..addComponent(Health(maxHitpoints: 10, hitpoints: 1))
      ..addComponent(pos.Position());
  }

  Entity enemyPlayer(double x, double y) {
    final entity = manager.createEntity();
    final body = playerBody(x, y);

    return entity
      ..addComponent(GameObject(body, entity))
      ..addComponent(Damage(hitpoints: 1))
      ..addComponent(Health(maxHitpoints: 10, hitpoints: 10))
      ..addComponent(pos.Position());
  }

  Entity map() {
    final entity = manager.createEntity();
    final body = mapBody([
      Vector2(-5, 5),
      Vector2(5, 5),
      Vector2(5, -5),
      Vector2(-5, -5),
    ]);

    return entity..addComponent(GameObject(body, entity));
  }
}
