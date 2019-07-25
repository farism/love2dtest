import '../../ecs/component.dart';
import '../flags.dart';

class AI extends Component {
  static const int Flag = ComponentFlags.AI;
  int flag = AI.Flag;

  static const String Id = 'AI';
  String id = AI.Id;

  AI();

  @override
  String toString() {
    return 'AI ()';
  }
}
