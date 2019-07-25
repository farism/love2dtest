import 'dart:collection';

import './component.dart';
import './entity.dart';
import './system.dart';

void defaultOnEmit(dynamic event) {}

class Manager {
  HashMap<int, HashMap<String, Component>> components = HashMap();
  HashMap<int, Entity> entities = HashMap();
  int nextId = 0;
  List<System> systems = [];

  // Manager({
  // });

  // void emit(T event) {
  //   onEmit(event);
  // }

  // managing entities

  int getNextEntityId() {
    return ++nextId;
  }

  Entity createEntity([String tag = '', bool add = true]) {
    var entity = Entity(this, getNextEntityId(), tag);

    if (add) {
      addEntity(entity);
    }

    return entity;
  }

  void addEntity(Entity entity) {
    entities[entity.id] = entity;

    check(entity);

    print('added entity -> $entity');
  }

  void removeEntity(Entity entity) {
    systems.forEach((system) {
      system.remove(entity);
    });

    components.remove(entity.id);

    entities.remove(entity.id);

    print('removed entity -> $entity');
  }

  // managing components

  T getComponent<T extends Component>(Entity entity, String id) {
    var map = components[entity.id];

    if (map != null) {
      return map[id] as T;
    }

    return null;
  }

  void addComponent(Entity entity, Component component) {
    entity.setFlag(component);

    var map = components.putIfAbsent(entity.id, () {
      return HashMap();
    });

    map.addAll({component.id: component});

    print('added component -> $component to entity -> $entity');

    check(entity);
  }

  void removeComponent(Entity entity, Component component) {
    entity.clearFlag(component);

    var map = components[entity.id];

    if (map != null) {
      map.remove(component.id);
    }

    print('removed component -> $component from entity -> $entity');

    check(entity);
  }

  void removeComponents(Entity entity) {}

  // managing systems

  void addSystems<T extends System>(List<T> systems) {
    systems.forEach((system) => addSystem(system));
  }

  void addSystem(System system) {
    system.setManager(this);

    entities.values.forEach((Entity entity) => system.check(entity));

    systems.add(system);

    print('added system -> $system');
  }

  void removeSystem(String id) {
    systems.removeWhere((system) => system.id == id);

    print('removed system ->  $id');
  }

  void check(Entity entity) {
    systems.forEach((system) => system.check(entity));
  }

  void update(double dt) {
    systems.forEach((system) => system.update(dt));
  }
}
