import 'dart:collection';

import 'component.dart';
import 'entity.dart';
import 'system.dart';

class Manager {
  HashMap<int, HashMap<String, Component>> components = HashMap();
  HashMap<int, Entity> entities = HashMap();
  int nextId = 0;
  List<System> systems = [];

  Manager();

  int getNextId() {
    return nextId++;
  }

  Entity createEntity([bool add = true]) {
    var entity = Entity(getNextId(), this);

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
    systems.forEach((system) => system.remove(entity));

    // removeComponents(entity);

    components.remove(entity.id);

    entities.remove(entity.id);

    print('removed entity -> $entity');
  }

  // managing components

  T getComponent<T>(Entity entity, String id) {
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

    print('added component -> $component to entity $entity');

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

  void removeComponents(Entity entity) {
    // (this.components.get(entity.id) || new Map()).values()
    //   function manager:removeComponents(entity)
    //     -- need to make this better
    //     for _, component in pairs(self.components[entity.id] or {}) do
    //       if (component.destroy) then
    //         component:destroy()
    //       end
    //       self:setComponent(entity, component, nil)
    //     end
    //   end
  }

  // managing systems

  void addSystem(System system) {
    // entities.updateAll((Entity entity) => entity);
    // entities.forEach((Entity entity) => system.check(entity));
    // this.systems.push(system)

    // system.setDebug(this.debug)

    // this.log(`added system (id: ${system._id})`)
  }

  void addSystems<T extends System>(List<T> systems) {
    systems.forEach((system) => addSystem(system));
  }

  void removeSystem(System system) {
    systems.removeWhere((s) => s.id == system.id);

    print('removed system ->  $system');
  }

  void check(Entity entity) {
    systems.forEach((system) => system.check(entity));
  }

  void update(double dt) {
    systems.forEach((system) => system.update(dt));
  }

  void draw() {
    systems.forEach((system) => system.draw());
  }
}
