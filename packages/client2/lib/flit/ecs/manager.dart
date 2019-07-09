import 'dart:collection';
import 'dart:ui';

import '../flit.dart';

class Manager {
  HashMap<int, HashMap<String, Component>> components = HashMap();
  HashMap<int, Entity> entities = HashMap();
  Game game;
  int nextId = 0;
  List<System> systems = [];
  List<Renderer> renderers = [];

  Manager(
    this.game, {
    List<Renderer> renderers = const [],
    List<System> systems = const [],
  }) {
    addRenderers(renderers);

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
    systems.forEach((system) => system.remove(entity));

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

  // managing renderers

  void addRenderers<T extends Renderer>(List<T> renderers) {
    renderers.forEach((renderer) => addRenderer(renderer));
  }

  void addRenderer(Renderer renderer) {
    entities.values.forEach((Entity entity) => renderer.check(entity));

    renderer.manager = this;

    renderers.add(renderer);

    print('added renderer -> $renderer');
  }

  void removeRenderer(String id) {
    renderers.removeWhere((s) => s.id == id);

    print('removed renderer ->  $id');
  }
  // managing systems

  void addSystems<T extends System>(List<T> systems) {
    systems.forEach((system) => addSystem(system));
  }

  void addSystem(System system) {
    entities.values.forEach((Entity entity) => system.check(entity));

    system.manager = this;

    systems.add(system);

    print('added system -> $system');
  }

  void removeSystem(String id) {
    systems.removeWhere((s) => s.id == id);

    print('removed system ->  $id');
  }

  void check(Entity entity) {
    systems.forEach((system) => system.check(entity));

    renderers.forEach((renderer) => renderer.check(entity));
  }

  void update(double dt) {
    systems.forEach((system) => system.update(dt));
  }

  void render(Canvas canvas, Camera camera) {
    renderers.forEach((renderer) => renderer.render(canvas, camera));
  }
}
