import '../../flit/flit.dart';
import '../components.dart';
import '../flags.dart';

class InputMovement extends System {
  static const int Flag = SystemFlags.Movement;
  int flag = InputMovement.Flag;

  static const String Id = 'movement';
  String id = InputMovement.Id;

  Aspect aspect = Aspect(all: [
    Position.Flag,
    Input.Flag,
  ]);

  @override
  void update(double dt) {}
}
