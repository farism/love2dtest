const getFlag = (index: number) => {
  return bit.lshift(1, index)
}

export enum ComponentFlag {
  Abilities = getFlag(0),
  Aggression = getFlag(1),
  Animation = getFlag(2),
  Attack = getFlag(3),
  Checkpoint = getFlag(4),
  Container = getFlag(5),
  Damage = getFlag(6),
  Dash = getFlag(7),
  GameObject = getFlag(8),
  Health = getFlag(9),
  Input = getFlag(10),
  Movement = getFlag(11),
  Platform = getFlag(12),
  Player = getFlag(13),
  Position = getFlag(14),
  Projectile = getFlag(15),
  Respawn = getFlag(16),
  Snare = getFlag(17),
  Sound = getFlag(18),
  Sprite = getFlag(19),
  Trigger = getFlag(20),
  Upgrades = getFlag(21),
  Wave = getFlag(22),
  Waypoint = getFlag(23),
  SyncBodyPosition = getFlag(24),
  Parallax = getFlag(25),
}

export enum SystemFlag {
  Abilities = getFlag(1),
  Aggression = getFlag(2),
  Animation = getFlag(3),
  Attack = getFlag(4),
  Checkpoint = getFlag(5),
  Container = getFlag(6),
  Damage = getFlag(7),
  Dash = getFlag(8),
  RenderSystem = getFlag(9),
  Health = getFlag(10),
  Input = getFlag(11),
  Movement = getFlag(12),
  Platform = getFlag(13),
  Player = getFlag(14),
  Position = getFlag(15),
  ProjectileSystem = getFlag(16),
  Respawn = getFlag(17),
  Snare = getFlag(18),
  Sound = getFlag(19),
  Sprite = getFlag(20),
  Trigger = getFlag(21),
  Upgrades = getFlag(22),
  Wave = getFlag(23),
  Waypoint = getFlag(24),
  SyncBodyPosition = getFlag(25),
  InputMovement = getFlag(26),
  JumpReset = getFlag(27),
  GameOver = getFlag(28),
  AnimateSprite = getFlag(29),
  FallDeath = getFlag(30),
  SpriteRender = getFlag(31),
  WaveMovement = getFlag(32),
  SetCurrentAnimation = getFlag(33),
  WaypointMovement = getFlag(34),
  Death = getFlag(35),
  ParallaxRender = getFlag(36),
  MovementValidation = getFlag(37),
  SyncDirection = getFlag(38),
}
