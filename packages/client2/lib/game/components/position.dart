import '../../ecs/ecs.dart';
import '../flags.dart';

class Position extends Component {
  static const int Flag = ComponentFlags.Position;
  int flag = Position.Flag;

  static const String Id = 'Position';
  String id = Position.Id;

  double x = 0;
  double y = 0;

  Position({
    this.x,
    this.y,
  });

  @override
  String toString() {
    return 'Position (x: $x, y: $y)';
  }
}
