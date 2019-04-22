const getFlag = (index: number) => {
  return bit.lshift(1, index)
}

export enum Flag {
  Abilities = getFlag(0),
  Animation = getFlag(1),
  Checkpoint = getFlag(2),
  Container = getFlag(3),
  Damage = getFlag(4),
  GameObject = getFlag(5),
  Health = getFlag(6),
  Input = getFlag(7),
  Movement = getFlag(8),
  Player = getFlag(9),
  Position = getFlag(10),
  Projectile = getFlag(11),
  Respawn = getFlag(12),
  Snare = getFlag(13),
  Sound = getFlag(14),
  Sprite = getFlag(15),
  Upgrades = getFlag(17),
  Wave = getFlag(18),
  Waypoint = getFlag(19),
  Aggression = getFlag(20),
  Attack = getFlag(21),
  Dash = getFlag(22),
  Platform = getFlag(23),
  Trigger = getFlag(24),
}
