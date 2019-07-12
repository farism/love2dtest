import '../../ecs/component.dart';
import '../flags.dart';

enum AbilityType { VANISH }

class Ability extends Component {
  static const int Flag = ComponentFlags.Ability;
  int flag = Ability.Flag;

  static const String Id = 'Ability';
  String id = Ability.Id;

  bool activated = false;
  int cooldown;
  int duration;

  Ability({
    this.cooldown = 0,
    this.duration = 0,
  });

  @override
  String toString() {
    return 'Ability ()';
  }
}
