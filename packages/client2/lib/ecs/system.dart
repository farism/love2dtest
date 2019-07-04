import 'dart:collection';
import 'aspect.dart';
import 'entity.dart';
import 'manager.dart';

class SystemFlags {
  static const int Movement = 1 << 0;
}

typedef Callback = Function(Entity);

abstract class ISystem {
  int flag;
  String id;
  Aspect aspect;

  void update(double dt);

  void draw();
}

abstract class System implements ISystem {
  static const int Flag = 0;

  static const String Id = 'system';

  bool debug = false;
  HashMap<int, Entity> entities = HashMap();
  Manager manager;
  Callback onAdd;
  Callback onRemove;
  bool paused = false;

  System(this.manager, this.onAdd, this.onRemove);

  void setDebug(bool debug) {
    this.debug = debug;
  }

  void updateAspect(Aspect aspect) => aspect = aspect;

  bool check(Entity entity) {
    // if (this._aspect.check(entity)) {
    //   if (!this.entities.get(entity.id)) {
    //     this.onAdd(entity)

    //     this.log(
    //       `entity (id :${entity.id}) is now being processed by system (id: ${
    //         this._id
    //       })`
    //     )
    //   }

    //   this.entities.set(entity.id, entity)
    // } else {
    //   if (this.entities.get(entity.id)) {
    //     this.onRemove(entity)
    //     this.log(
    //       `entity (id :${
    //         entity.id
    //       }) is no longer being processed by system (id: ${this._id})`
    //     )
    //   }

    //   this.entities.delete(entity.id)
    // }
  }

  void add(Entity entity) {
    this.entities[entity.id] = entity;

    this.onAdd(entity);
  }

  void remove(Entity entity) {
    this.entities.remove(entity.id);

    this.onRemove(entity);
  }
}

class MovementSystem extends System {
  static const int Flag = SystemFlags.Movement;
  int flag = MovementSystem.Flag;

  static const String Id = 'movement';
  String id = MovementSystem.Id;

  Aspect aspect = Aspect();

  MovementSystem(Manager manager, Callback onAdd, Callback onRemove)
      : super(manager, onAdd, onRemove);

  void update(double dt) {}

  void draw() {}
}
