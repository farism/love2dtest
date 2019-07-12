import 'package:box2d_flame/box2d.dart';

import '../ecs/ecs.dart';
import './components/game_object.dart';
import './components/health.dart';

class EntityFactory {
  Manager manager;
  World world;

  EntityFactory(this.manager, this.world);

  Entity player() {
    Entity entity = manager.createEntity();

    CircleShape circle = CircleShape()..radius = 10;

    FixtureDef fixtureDef = FixtureDef()..shape = circle;

    BodyDef bodyDef = BodyDef()
      ..position = Vector2(0, 0)
      ..type = BodyType.DYNAMIC;

    Body body = world.createBody(bodyDef)
      ..userData = {'entity': entity}
      ..createFixtureFromFixtureDef(fixtureDef);

    return entity..addComponent(GameObject(body: body))..addComponent(Health());
  }
}
