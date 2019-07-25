import '../../ecs/component.dart';
import '../flags.dart';

class Player extends Component {
  static const int Flag = ComponentFlags.Player;
  int flag = Player.Flag;

  static const String Id = 'Player';
  String id = Player.Id;

  String alias;
  bool isUser;

  Player({
    this.alias = '',
  });

  @override
  String toString() {
    return 'Player (alias: $alias)';
  }
}
