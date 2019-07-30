import 'package:box2d_flame/box2d.dart';

import '../../ecs/ecs.dart';
import '../flags.dart';

class Input extends Component {
  static const int Flag = ComponentFlags.Input;
  int flag = Input.Flag;

  static const String Id = 'Input';
  String id = Input.Id;

  Vector2 dragStart;
  Vector2 dragCurrent;
  Vector2 dragEnd;

  Input();
}
