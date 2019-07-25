import 'package:box2d_flame/box2d.dart';

import '../ecs/entity.dart';

class ContactResult {
  final Contact contact;
  final Entity entityA;
  final Entity entityB;
  final Fixture fixtureA;
  final Fixture fixtureB;

  ContactResult({
    this.contact,
    this.entityA,
    this.entityB,
    this.fixtureA,
    this.fixtureB,
  });
}

ContactResult getContactResult(
  Entity Function(dynamic userData) getEntity,
  Contact contact,
) {
  return ContactResult(
    contact: contact,
    entityA: getEntity(contact.fixtureA.getBody().userData),
    entityB: getEntity(contact.fixtureB.getBody().userData),
    fixtureA: contact.fixtureA,
    fixtureB: contact.fixtureB,
  );
}
