import 'dart:math';

import './base/collision_system.dart';
import '../../ecs/ecs.dart';
import '../box2d.dart';
import '../components/damage.dart';
import '../components/health.dart';
import '../flags.dart';

class CollisionDamage extends CollisionSystem {
  static const int Flag = SystemFlags.CollisionDamage;
  int flag = CollisionDamage.Flag;

  static const String Id = 'CollisionDamage';
  String id = CollisionDamage.Id;

  Aspect aspect = Aspect(all: [
    Health.Flag,
    Damage.Flag,
  ]);

  @override
  void update(double dt) {}

  @override
  void beginContact(ContactResult result) {
    Health healthA = result.entityA.as<Health>(Health.Id);
    Health healthB = result.entityB.as<Health>(Health.Id);

    if (healthA == null || healthB == null) {
      return;
    }

    healthA.hitpoints = max(0, healthA.hitpoints - 1);
    healthB.hitpoints = max(0, healthB.hitpoints - 1);
  }

  @override
  void endContact(ContactResult result) {}
}
