import 'package:box2d_flame/box2d.dart';
import 'package:flutter/widgets.dart';

import './base/render_system.dart';
import '../../ecs/ecs.dart';
import '../camera.dart';
import '../components/drag_input.dart';
import '../components/game_object.dart';
import '../flags.dart';

class AttackTrajectorySystem extends RenderSystem {
  static const int Flag = SystemFlags.Drag;
  int flag = AttackTrajectorySystem.Flag;

  static const String Id = 'AttackTrajectorySystem';
  String id = AttackTrajectorySystem.Id;

  Aspect aspect = Aspect(all: [DragInput.Flag]);

  Camera camera;

  AttackTrajectorySystem(this.camera);

  @override
  void render(Canvas canvas) {
    entities.values.forEach((entity) {
      final go = entity.as<GameObject>(GameObject.Id);
      final di = entity.as<DragInput>(DragInput.Id);

      if (go == null || di == null || di.start == null || di.current == null) {
        return;
      }

      // print(go.body.getAngle());

      final center = camera.project(go.body, Vector2(0, 0));
      final distance = (di.current - di.start)..scale(-1);
      // ..clampScalar(-100, 100);

      canvas.drawLine(
        Offset(center.x, center.y),
        Offset(center.x + distance.x, center.y + distance.y),
        Paint()..color = Color(0xFFFFFFFF),
      );
    });
  }
}
