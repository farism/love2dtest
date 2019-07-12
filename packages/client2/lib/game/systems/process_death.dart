import '../../ecs/ecs.dart';
import '../components/health.dart';
import '../flags.dart';

class ProcessDeath extends ProcessingSystem {
  static const int Flag = ProcessingSystemFlags.ProcessDeath;
  int flag = ProcessDeath.Flag;

  static const String Id = 'ProcessDeath';
  String id = ProcessDeath.Id;

  ProcessDeath(Manager manager) : super(manager);

  Aspect aspect = Aspect(all: [
    Health.Flag,
  ]);

  @override
  void update(double dt) {
    entities.values.forEach((entity) {});
  }
}
