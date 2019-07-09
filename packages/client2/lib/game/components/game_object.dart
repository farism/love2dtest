import 'package:box2d_flame/box2d.dart';

import '../../flit/flit.dart';
import '../flags.dart';

class GameObject extends Component {
  static const int Flag = ComponentFlags.GameObject;
  int flag = GameObject.Flag;

  static const String Id = 'input';
  String id = GameObject.Id;

  Body _body;

  GameObject(Body body) {
    _body = body;
  }

  Body get body => _body;
}
