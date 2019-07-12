import 'package:box2d_flame/box2d.dart';

import '../../ecs/ecs.dart';
import '../flags.dart';

class Map extends Component {
  static const int Flag = ComponentFlags.Map;
  int flag = Map.Flag;

  static const String Id = 'Map';
  String id = Map.Id;

  List<Vector2> boundary;
  String image;

  Map({
    this.boundary,
    this.image,
  });
}
