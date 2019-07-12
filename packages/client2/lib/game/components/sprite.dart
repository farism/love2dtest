import '../../ecs/component.dart';
import '../flags.dart';

class Sprite extends Component {
  static const int Flag = ComponentFlags.Sprite;
  int flag = Sprite.Flag;

  static const String Id = 'Sprite';
  String id = Sprite.Id;

  String image;

  Sprite({
    this.image = '',
  });

  @override
  String toString() {
    return 'Sprite (image: $image)';
  }
}
