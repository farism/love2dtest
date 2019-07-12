class ComponentFlags {
  static const int Input = 1 << 0;
  static const int Position = 1 << 1;
  static const int GameObject = 1 << 2;
  static const int Health = 1 << 3;
  static const int Player = 1 << 4;
  static const int Snare = 1 << 5;
  static const int Sprite = 1 << 6;
  static const int Damage = 1 << 7;
  static const int Ability = 1 << 8;
  static const int Map = 1 << 9;
}

class ProcessingSystemFlags {
  static const int ProcessDeath = 1 << 0;
}

class RenderingSystemFlags {
  static const int RenderDebugWorld = 1 << 0;
  static const int RenderSprite = 1 << 1;
}
