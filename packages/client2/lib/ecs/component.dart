class ComponentFlags {
  static const int Input = 1 << 0;
  static const int Position = 1 << 1;
}

abstract class IComponent {
  int flag;
  String id;
}

abstract class Component implements IComponent {}

class Position extends Component {
  static const int Flag = ComponentFlags.Position;
  int flag = Position.Flag;

  static const String Id = 'position';
  String id = Position.Id;

  double x = 0;
  double y = 0;

  Position(this.x, this.y);

  @override
  String toString() {
    return 'Position (x: $x, y: $y)';
  }
}

class Input implements Component {
  static const int Flag = ComponentFlags.Input;
  int flag = Input.Flag;

  static const String Id = 'input';
  String id = Input.Id;

  Input();
}
