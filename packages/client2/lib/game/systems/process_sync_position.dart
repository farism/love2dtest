import 'package:box2d_flame/box2d.dart' as box2d;

import './base/system.dart';
import '../../ecs/ecs.dart';
import '../camera.dart';
import '../components/game_object.dart';
import '../components/position.dart';
import '../flags.dart';

class ProcessSyncPosition extends BaseSystem {
  static const int Flag = SystemFlags.ProcessSyncPosition;
  int flag = ProcessSyncPosition.Flag;

  static const String Id = 'ProcessSyncPosition';
  String id = ProcessSyncPosition.Id;

  Aspect aspect = Aspect(all: [
    Position.Flag,
    GameObject.Flag,
  ]);

  Camera camera;

  ProcessSyncPosition(this.camera);

  @override
  void update(double dt) {
    entities.values.forEach((entity) {
      final go = entity.as<GameObject>(GameObject.Id);
      final pos = entity.as<Position>(Position.Id);

      if (go == null || pos == null) {
        return;
      }

      final center = camera.project(go.body, box2d.Vector2.zero());

      pos.x = center.x;
      pos.y = center.y;
    });
  }
}
