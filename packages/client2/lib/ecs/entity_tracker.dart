import 'dart:collection';

import './aspect.dart';
import './entity.dart';
import './manager.dart';

abstract class IEntityTracker {
  Aspect aspect;
}

abstract class EntityTracker implements IEntityTracker {
  HashMap<int, Entity> entities = HashMap();
  Manager manager;
  bool paused = false;

  EntityTracker(this.manager);

  set setAspect(Aspect aspect) {
    aspect = aspect;

    checkAll();
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
}
