import '../../ecs/component.dart';
import '../flags.dart';

class Damage extends Component {
  static const int Flag = ComponentFlags.Damage;
  int flag = Damage.Flag;

  static const String Id = 'Damage';
  String id = Damage.Id;

  int hitpoints;

  Damage({
    this.hitpoints,
  });

  @override
  String toString() {
    return 'Damage (hp: $hitpoints)';
  }
}
