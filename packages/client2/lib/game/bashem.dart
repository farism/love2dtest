import 'dart:ui';
import 'package:box2d_flame/box2d.dart';
import 'package:flutter/widgets.dart';

import '../flit/flit.dart';
import './components.dart';
import './renderers.dart';
import './systems.dart';

void createWall(Game game, Vector2 p1, Vector2 p2) {
  game.createEntity()
    ..addComponent(
      GameObject(
        game.world.createBody(
          BodyDef()
            ..position = Vector2.zero()
            ..type = BodyType.STATIC,
        )..createFixtureFromFixtureDef(
            FixtureDef()
              ..shape = (PolygonShape()
                ..setAsEdge(
                  p1,
                  p2,
                )),
          ),
      ),
    );
}

void createPlayer(Game game, double x, double y) {
  final body = game.world.createBody(
    BodyDef()
      ..bullet = true
      ..position = Vector2(x, y)
      ..setLinearDamping(1)
      ..type = BodyType.DYNAMIC,
  )..createFixtureFromFixtureDef(
      FixtureDef()
        ..restitution = 0.75
        // ..density = 0.0001
        ..shape = (CircleShape()..radius = 1),
    );

  game.createEntity()..addComponent(GameObject(body));

  Future.delayed(Duration(milliseconds: 1000), () {
    body.applyLinearImpulse(Vector2(0, 100), body.position, true);
  });
}

const double WORLD_WIDTH = 10.0;
const double WORLD_HEIGHT = WORLD_WIDTH * 9 / 16;

class BashEm {
  Game game;

  BashEm() {
    game = Game(
      gravity: 0,
      screenPPM:
          window.physicalSize.width / window.devicePixelRatio / WORLD_WIDTH / 2,
      screenWidth: window.physicalSize.width / window.devicePixelRatio,
      screenHeight: window.physicalSize.height / window.devicePixelRatio,
      renderers: [
        GameObjectRenderer(),
      ],
      systems: [
        InputMovement(),
      ],
    );

    // top
    createWall(
      game,
      Vector2(-WORLD_WIDTH, -WORLD_HEIGHT * 2),
      Vector2(WORLD_WIDTH, -WORLD_HEIGHT * 2),
    );

    // bottom
    createWall(
      game,
      Vector2(-WORLD_WIDTH, WORLD_HEIGHT * 2),
      Vector2(WORLD_WIDTH, WORLD_HEIGHT * 2),
    );

    // left
    createWall(
      game,
      Vector2(-WORLD_WIDTH, WORLD_HEIGHT * 2),
      Vector2(-WORLD_WIDTH, -WORLD_HEIGHT * 2),
    );

    // right
    createWall(
      game,
      Vector2(WORLD_WIDTH, WORLD_HEIGHT * 2),
      Vector2(WORLD_WIDTH, -WORLD_HEIGHT * 2),
    );

    createPlayer(game, 0, 0);

    Future.delayed(Duration(milliseconds: 2000), () {
      createPlayer(game, 1, -5);
    });
  }

  Widget get widget {
    return game.widget;
  }
}
