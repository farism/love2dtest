class ComponentFlags {
  static const int DragInput = 1 << 0;
  static const int Position = 1 << 1;
  static const int GameObject = 1 << 2;
  static const int Health = 1 << 3;
  static const int Player = 1 << 4;
  static const int Snare = 1 << 5;
  static const int Sprite = 1 << 6;
  static const int Damage = 1 << 7;
  static const int Ability = 1 << 8;
  static const int Map = 1 << 9;
  static const int AI = 1 << 10;
  static const int Turn = 1 << 11;
}

class SystemFlags {
  static const int CollisionHandler = 1 << 0;
  static const int Damage = 1 << 2;
  static const int Death = 1 << 3;
  static const int DragInput = 1 << 4;
  static const int AI = 1 << 5;
  static const int SyncPositionSystem = 1 << 6;
  static const int Turn = 1 << 7;
  static const int Drag = 1 << 8;
  static const int DebugWorld = 1 << 9;
  static const int Sprite = 1 << 10;
  static const int Health = 1 << 11;
}
