import 'dart:collection';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';

import '../ecs/component.dart' as Component;
import '../ecs/entity.dart';
import '../ecs/manager.dart';
import 'world.dart';

class MyGame extends BaseGame {
  final TextConfig fpsTextConfig = TextConfig(color: const Color(0xFFFF0000));
  final World world = World();
  final Manager manager = Manager();

  MyGame() {
    manager.createEntity();
    // this
    //     .manager
    //     .addComponent(Entity(0, this.manager), Component.Position(0, 0));

    // var foo = Position(0, 0);

    // HashMap<String, Object> foo = HashMap.from({
    //   Component.Position.Id: Component.Position(0, 0),
    //   Component.Input.Id: Component.Input(),
    // });

    // var bar = foo[Component.Position.Id] as Component.Position;

    // if (bar == null) {
    //   return;
    // }

    // print(bar.x);

    //     components.putIfAbsent(0, () => Component.Position(0, 0));

    // var c2 = components[0] as Component.Position;

    // if (components[0] as Component.Position != null) {
    //   print('here2');
    //   print(c2);
    // }

    // var bar = foo.getAs(Position);

    // print(foo.);
    // print(Position(0, 0).flag);
  }

  void addGestures() {
    Flame.util.addGestureRecognizer(
      TapGestureRecognizer()
        ..onTapDown = (TapDownDetails evt) {
          // print(evt.localPosition);
        }
        ..onTapUp = (TapUpDetails evt) {
          // print(evt.localPosition);
        },
    );
  }

  @override
  bool debugMode() => true;

  @override
  void render(Canvas canvas) {
    world.render(canvas);
    fpsTextConfig.render(canvas, fps(120).toString(), Position(0, 20));
  }

  @override
  void resize(Size size) {
    super.resize(size);
    world.resize(size);
  }

  @override
  void update(double dt) {
    super.update(dt);
    world.update(dt);
  }
}
