import '../../flit/flit.dart';
import '../flags.dart';

class Input implements Component {
  static const int Flag = ComponentFlags.Input;
  int flag = Input.Flag;

  static const String Id = 'input';
  String id = Input.Id;

  Input();
}
