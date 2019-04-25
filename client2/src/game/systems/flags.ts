const getFlag = (index: number) => {
  return bit.lshift(1, index)
}

export enum Flag {
  Abilities = getFlag(1),
  Aggression = getFlag(2),
  Animation = getFlag(3),
  Attack = getFlag(4),
  Checkpoint = getFlag(5),
  Container = getFlag(6),
  Damage = getFlag(7),
  Dash = getFlag(8),
  GameObjectRenderer = getFlag(9),
  Health = getFlag(10),
  Input = getFlag(11),
  Movement = getFlag(12),
  Platform = getFlag(13),
  Player = getFlag(14),
  Position = getFlag(15),
  Projectile = getFlag(16),
  Respawn = getFlag(17),
  Snare = getFlag(18),
  Sound = getFlag(19),
  Sprite = getFlag(20),
  Trigger = getFlag(21),
  Upgrades = getFlag(22),
  Wave = getFlag(23),
  Waypoint = getFlag(24),
}
