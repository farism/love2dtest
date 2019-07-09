import '../ecs/entity.dart';
import '../ecs/manager.dart';

Entity createGround(Manager manager) {
  // const body = love.physics.newBody(
  //   manager.world,
  //   WINDOW_WIDTH / 2,
  //   WINDOW_HEIGHT - 16,
  //   'static'
  // )

  // body.setGravityScale(0)
  // const shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30)
  // const fixture = love.physics.newFixture(body, shape, 1)

  var entity = manager.createEntity();
  // entity.userData = { blueprint: Blueprint.Ground }
  // entity.addAll([new GameObject(entity, fixture)])

  return entity;
}
