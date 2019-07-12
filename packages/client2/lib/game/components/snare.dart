import '../../ecs/component.dart';
import '../flags.dart';

class Snare extends Component {
  static const int Flag = ComponentFlags.Snare;
  int flag = Snare.Flag;

  static const String Id = 'Snare';
  String id = Snare.Id;

  String strength;

  Snare({
    this.strength = '',
  });

  @override
  String toString() {
    return 'Snare (strength: $strength)';
  }
}
