import 'package:box2d_flame/box2d.dart';

import './base/system.dart';
import '../../ecs/ecs.dart';
import '../components/game_object.dart';
import '../components/input.dart';
import '../flags.dart';

class ProcessAttack extends BaseSystem {
  static const int Flag = SystemFlags.ProcessAttack;
  int flag = ProcessAttack.Flag;

  static const String Id = 'ProcessAttack';
  String id = ProcessAttack.Id;

  Aspect aspect = Aspect(all: [Input.Flag, GameObject.Flag]);

  @override
  update(double dt) {
    entities.values.forEach((entity) {
      final di = entity.as<Input>(Input.Id);

      if (di == null) {
        return;
      }

      if (di.dragStart != null && di.dragEnd != null) {
        if (entity.tag == 'user') {
          final go = entity.as<GameObject>(GameObject.Id);

          final distance = (di.dragEnd - di.dragStart)
            ..multiply(Vector2(-0.5, 0.5));

          final origin = go.body.position
            ..clone()
            ..add(Vector2(0.1, 0.1));

          go.body.applyLinearImpulse(distance, origin, true);
        }

        di.dragStart = di.dragCurrent = di.dragEnd = null;
      }
    });
  }
}
