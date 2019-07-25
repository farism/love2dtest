import 'package:box2d_flame/box2d.dart';

import './system.dart';
import '../../box2d.dart';

abstract class CollisionSystem extends BaseSystem {
  bool shouldBeginContact(ContactResult result) {
    return hasEntities(result.entityA, result.entityB);
  }

  bool shouldEndContact(ContactResult result) {
    return hasEntities(result.entityA, result.entityB);
  }

  void beginContact(ContactResult result);

  void endContact(ContactResult result);

  void preSolve(ContactResult result, Manifold oldManifold) {}

  void postSolve(ContactResult result, ContactImpulse impulse) {}
}
