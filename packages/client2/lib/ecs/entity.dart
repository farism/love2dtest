import './component.dart';
import './manager.dart';

class Entity {
  int components = 0;
  int id = 0;
  Manager manager;
  int renderers = 0;
  int systems = 0;
  String tag = '';

  Entity(this.manager, this.id, this.tag);

  T as<T extends Component>(String id) {
    return manager.getComponent<T>(this, id);
  }

  bool hasComponent(Component component) {
    return components & component.flag != 0;
  }

  Entity addComponent(Component component) {
    manager.addComponent(this, component);

    return this;
  }

  void addComponents(List<Component> components) {
    components.forEach((component) => manager.addComponent(this, component));
  }

  void removeComponent(Component component) {
    manager.removeComponent(this, component);
  }

  void removeComponents(List<Component> components) {
    components.forEach((component) => manager.removeComponent(this, component));
  }

  void clearFlag(Component component) {}

  void clearFlags(List<Component> components) {
    components.forEach((component) => clearFlag(component));
  }

  void setFlag(Component component) {
    components = components ^ component.flag;
  }

  void setFlags(List<Component> components) {
    components.forEach((component) => setFlag(component));
  }

  void destroy() {
    manager.removeEntity(this);
  }

  @override
  String toString() {
    return 'Entity (tag: $tag, id: $id)';
  }
}
