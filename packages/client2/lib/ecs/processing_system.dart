import './manager.dart';
import './system.dart';

abstract class ProcessingSystem extends System {
  ProcessingSystem(Manager manager) : super(manager);

  SystemType getSystemType() => SystemType.processing;

  void update(double dt);
}
