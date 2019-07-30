import 'package:box2d_flame/box2d.dart';
import 'package:flutter/widgets.dart';

import './base/render_system.dart';
import '../../ecs/ecs.dart';
import '../camera.dart';
import '../components/input.dart';
import '../components/game_object.dart';
import '../flags.dart';

class RenderAttackTrajectory extends RenderSystem {
  static const int Flag = SystemFlags.RenderAttackTrajectory;
  int flag = RenderAttackTrajectory.Flag;

  static const String Id = 'RenderAttackTrajectory';
  String id = RenderAttackTrajectory.Id;

  Aspect aspect = Aspect(all: [Input.Flag]);

  Camera camera;

  RenderAttackTrajectory(this.camera);

  @override
  void render(Canvas canvas) {
    entities.values.forEach((entity) {
      final gameObject = entity.as<GameObject>(GameObject.Id);
      final input = entity.as<Input>(Input.Id);

      if (gameObject == null || input == null) {
        return;
      }

      if (input.dragStart == null || input.dragCurrent == null) {
        return;
      }

      final center = camera.project(gameObject.body, Vector2(0, 0));
      final inputstance = (input.dragCurrent - input.dragStart)..scale(-1);
      // ..clampScalar(-100, 100);

      canvas.drawLine(
        Offset(center.x, center.y),
        Offset(center.x + inputstance.x, center.y + inputstance.y),
        Paint()..color = Color(0xFFFFFFFF),
      );
    });
  }
}
