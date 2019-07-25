import '../../ecs/component.dart';
import '../flags.dart';

class Turn extends Component {
  static const int Flag = ComponentFlags.Turn;
  int flag = Turn.Flag;

  static const String Id = 'Turn';
  String id = Turn.Id;

  bool active = false;

  Turn({
    this.active,
  });

  @override
  String toString() {
    return 'Turn ()';
  }
}
