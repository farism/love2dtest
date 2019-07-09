class ComponentFlags {
  static const int Input = 1 << 0;
  static const int Position = 1 << 1;
  static const int GameObject = 1 << 2;
}

class SystemFlags {
  static const int Movement = 1 << 0;
}

class RendererFlags {
  static const int GameObjectRenderer = 1 << 0;
}
