import 'package:box2d_flame/box2d.dart';

import './base/input_system.dart';
import '../../ecs/ecs.dart';
import '../components/drag_input.dart';
import '../components/game_object.dart';
import '../flags.dart';

class AttackSystem extends InputSystem {
  static const int Flag = SystemFlags.Drag;
  int flag = AttackSystem.Flag;

  static const String Id = 'AttackSystem';
  String id = AttackSystem.Id;

  Aspect aspect = Aspect(all: [DragInput.Flag, GameObject.Flag]);

  @override
  update(double dt) {
    entities.values.forEach((entity) {
      final di = entity.as<DragInput>(DragInput.Id);

      if (di == null) {
        return;
      }

      if (di.start != null && di.end != null) {
        if (entity.tag == 'user') {
          final go = entity.as<GameObject>(GameObject.Id);
          final distance = (di.end - di.start)..multiply(Vector2(-0.5, 0.5));

          go.body.applyLinearImpulse(
            distance,
            go.body.position..add(Vector2(0.1, 0.1)),
            true,
          );
        }

        di.start = di.current = di.end = null;
      }
    });
  }
}
