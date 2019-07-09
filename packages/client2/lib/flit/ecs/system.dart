import './entity_tracker.dart';

abstract class ISystem {
  int flag;
  String id;
}

abstract class System extends EntityTracker implements ISystem {
  bool paused = false;

  void update(double dt) {}
}
