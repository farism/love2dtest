const getFlag = (index: number) => {
  return bit.lshift(1, index)
}

export enum Flag {
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
}
