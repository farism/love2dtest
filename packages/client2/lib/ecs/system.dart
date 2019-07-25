import 'dart:collection';

import './aspect.dart';
import './entity.dart';
import './manager.dart';

abstract class ISystem {
  Aspect aspect;
  int flag;
  String id;
}

abstract class System implements ISystem {
  HashMap<int, Entity> entities = HashMap();
  Manager manager;
  bool paused = false;

  void setManager(Manager m) {
    manager = m;
  }

  void setAspect(Aspect a) {
    aspect = a;

    checkAll();
  }

  bool hasEntities(Entity entityA, Entity entityB) {
    return entities[entityA.id] != null && entities[entityB.id] != null;
  }

  void checkAll() {
    entities.values.forEach(check);
  }

  void check(Entity entity) {
    if (aspect.check(entity)) {
      add(entity);
    } else {
      remove(entity);
    }
  }

  void add(Entity entity) {
    if (entities[entity.id] == null) {
      print('entity -> $entity is now being processed by system $this');
    }

    entities[entity.id] = entity;

    onAdd(entity);
  }

  void remove(Entity entity) {
    if (entities[entity.id] != null) {
      print('entity -> $entity is no longer being processed by system $this');

      onRemove(entity);

      entities.remove(entity.id);
    }
  }

  void onAdd(Entity entity) {}

  void onRemove(Entity entity) {}

  void update(double dt);
}
