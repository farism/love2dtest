import 'dart:collection';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';

import './collision_system.dart';
import './component.dart';
import './entity.dart';
import './system.dart';
import './processing_system.dart';
import './rendering_system.dart';

class Manager {
  HashMap<int, HashMap<String, Component>> components = HashMap();
  HashMap<int, Entity> entities = HashMap();
  int nextId = 0;
  HashMap<SystemType, List<System>> systems = HashMap()
    ..addAll({
      SystemType.collision: [],
      SystemType.processing: [],
      SystemType.rendering: [],
    });

  Manager({
    List<System> systems = const [],
  }) {
    addSystems(systems);
  }

  // managing entities

  int getNextEntityId() {
    return ++nextId;
  }

  Entity createEntity([bool add = true]) {
    var entity = Entity(getNextEntityId(), this);

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
    systems.values.forEach((List<System> _systems) {
      _systems.forEach((system) => system.remove(entity));
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
    entities.values.forEach((Entity entity) => system.check(entity));

    systems[system.getSystemType()].add(system);

    print('added system -> $system');
  }

  void removeSystem(String id) {
    systems.values.forEach((List<System> _systems) {
      _systems.removeWhere((system) => system.id == id);
    });

    print('removed system ->  $id');
  }

  void check(Entity entity) {
    systems.values.forEach((List<System> _systems) {
      _systems.forEach((system) => system.check(entity));
    });
  }

  // lifecycles
  void beginContact(Contact contact) {
    systems[SystemType.processing].forEach((System system) {
      CollisionSystem _system = system;

      _system.beginContact(contact);
    });
  }

  void endContact(Contact contact) {
    systems[SystemType.collision].forEach((System system) {
      CollisionSystem _system = system;

      _system.endContact(contact);
    });
  }

  void render(Canvas canvas) {
    systems[SystemType.rendering].forEach((System system) {
      RenderingSystem _system = system;

      _system.render(canvas);
    });
  }

  void update(double dt) {
    systems[SystemType.processing].forEach((System system) {
      ProcessingSystem _system = system;

      _system.update(dt);
    });
  }
}
