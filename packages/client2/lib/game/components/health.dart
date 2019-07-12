import '../../ecs/component.dart';
import '../flags.dart';

class Health extends Component {
  static const int Flag = ComponentFlags.Health;
  int flag = Health.Flag;

  static const String Id = 'Health';
  String id = Health.Id;

  int armor;
  int hitpoints;
  int maxArmor;
  int maxHitpoints;

  Health({
    this.armor = 0,
    this.hitpoints = 0,
    this.maxArmor = 0,
    this.maxHitpoints = 0,
  });

  @override
  String toString() {
    return 'Health (hp: $hitpoints / $maxHitpoints, armor: $armor / $maxArmor)';
  }
}
