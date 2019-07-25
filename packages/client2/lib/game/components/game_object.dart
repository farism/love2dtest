import 'package:box2d_flame/box2d.dart';

import '../../ecs/component.dart';
import '../flags.dart';

class GameObject extends Component {
  static const int Flag = ComponentFlags.GameObject;
  int flag = GameObject.Flag;

  static const String Id = 'Input';
  String id = GameObject.Id;

  Body body;

  GameObject(this.body, entity) {
    this.body.userData = {'entity': entity};
  }
}
