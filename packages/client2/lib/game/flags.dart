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
  static const int AI = 1 << 10;
  static const int Turn = 1 << 11;
}

class SystemFlags {
  static const int CollisionDamage = 1 << 2;
  static const int ProcessDeath = 1 << 3;
  static const int InputDrag = 1 << 4;
  static const int ProcessAI = 1 << 5;
  static const int ProcessSyncPosition = 1 << 6;
  static const int ProcessTurn = 1 << 7;
  static const int RenderAttackTrajectory = 1 << 8;
  static const int RenderDebugWorld = 1 << 9;
  static const int RenderSprite = 1 << 10;
  static const int RenderHealth = 1 << 11;
  static const int ProcessAttack = 1 << 12;
}
