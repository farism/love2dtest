import './entity_tracker.dart';
import './manager.dart';

abstract class ISystem {
  int flag;
  String id;
}

abstract class System extends EntityTracker implements ISystem {
  System(Manager manager) : super(manager);

  void update(double dt) {}
}
