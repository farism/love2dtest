import 'package:box2d_flame/box2d.dart';

import './manager.dart';
import './system.dart';

abstract class CollisionSystem extends System {
  CollisionSystem(Manager manager) : super(manager);

  SystemType getSystemType() => SystemType.collision;

  void beginContact(Contact contact);

  void endContact(Contact contact);
}
