import 'component.dart';
import 'manager.dart';

class Entity {
  int id = 0;
  int components = 0;
  Manager manager;

  Entity(int id, Manager manager) {
    this.id = id;
    this.manager = manager;
  }

  T as<T>(Component c) {
    // return this.manager.getComponent(this, Component) as T;
  }

  void addComponent(Component component) {
    this.manager.addComponent(this, component);
  }

  void addComponents(List<Component> components) {
    components.forEach((component) {
      this.manager.addComponent(this, component);
    });
  }

  void removeComponent(Component component) {
    this.manager.removeComponent(this, component);
  }

  bool hasComponent(Component component) {
    return true;
  }

  void destroy() {
    this.manager.removeEntity(this);
  }

  void clearFlag(Component component) {}

  void setFlag(Component component) {
    // this.components = this.components ^ component.flag;
  }

  // operator []=(int i, int value) => _list[i] = value; // set

  @override
  String toString() {
    return 'Entity (id: $id)';
  }
}
