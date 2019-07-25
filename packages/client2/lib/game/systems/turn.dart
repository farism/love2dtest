import './base/system.dart';
import '../../ecs/ecs.dart';
import '../components/turn.dart';
import '../flags.dart';

class TurnSystem extends BaseSystem {
  static const int Flag = SystemFlags.Turn;
  int flag = TurnSystem.Flag;

  static const String Id = 'TurnSystem';
  String id = TurnSystem.Id;

  Aspect aspect = Aspect(all: [Turn.Flag]);

  @override
  void update(double dt) {
    entities.values.forEach((entity) {});
  }
}
