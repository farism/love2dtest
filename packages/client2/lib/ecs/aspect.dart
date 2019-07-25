import './entity.dart';

int flags(List<int> components) {
  return components.fold(0, (acc, flag) {
    return acc ^ flag;
  });
}

class Aspect {
  int all = 0;
  int none = 0;
  int one = 0;

  Aspect({
    List<int> all = const [],
    List<int> none = const [],
    List<int> one = const [],
  }) {
    this.all = flags(all);
    this.none = flags(none);
    this.one = flags(one);
  }

  bool check(Entity entity) {
    bool all = (this.all | entity.components) == entity.components;
    bool none = (this.none & entity.components) == 0;
    bool one = (this.one & entity.components) != 0;

    return (one || all) && none;
  }
}

class AlwaysAspect extends Aspect {
  @override
  bool check(_) => true;
}

class NeverAspect extends Aspect {
  @override
  bool check(_) => false;
}
