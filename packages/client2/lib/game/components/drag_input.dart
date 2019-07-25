import 'package:box2d_flame/box2d.dart';

import '../../ecs/ecs.dart';
import '../flags.dart';

class DragInput extends Component {
  static const int Flag = ComponentFlags.DragInput;
  int flag = DragInput.Flag;

  static const String Id = 'DragInput';
  String id = DragInput.Id;

  Vector2 start;
  Vector2 current;
  Vector2 end;

  DragInput();
}
