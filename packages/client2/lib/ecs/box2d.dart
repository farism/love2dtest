import 'package:box2d_flame/box2d.dart';

abstract class CollisionHandler implements ContactListener {
  @override
  void beginContact(Contact contact) {
    startCollision(contact.fixtureA, contact.fixtureB, contact);
  }

  @override
  void endContact(Contact contact) {
    endCollision(contact.fixtureA, contact.fixtureB, contact);
  }

  void startCollision(Fixture fixture1, Fixture fixture2, Contact contact);

  void endCollision(Fixture fixture1, Fixture fixture2, Contact contact);
}
