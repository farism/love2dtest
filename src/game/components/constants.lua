local flag = require 'game.utils.flag'

local constants = {
  Ability = {id = 'ability', flag = flag(0)},
  Animation = {id = 'animation', flag = flag(1)},
  Checkpoint = {id = 'checkpoint', flag = flag(2)},
  Container = {id = 'container', flag = flag(3)},
  Damage = {id = 'damage', flag = flag(4)},
  Fixture = {id = 'fixture', flag = flag(5)},
  Health = {id = 'health', flag = flag(6)},
  Input = {id = 'input', flag = flag(7)},
  Movement = {id = 'movement', flag = flag(8)},
  Player = {id = 'player', flag = flag(9)},
  Position = {id = 'position', flag = flag(10)},
  Projectile = {id = 'projectile', flag = flag(11)},
  Respawn = {id = 'respawn', flag = flag(12)},
  Snare = {id = 'snare', flag = flag(13)},
  Sound = {id = 'movement', flag = flag(14)},
  Sprite = {id = 'sprite', flag = flag(15)},
  Upgrades = {id = 'upgrades', flag = flag(17)},
  Wave = {id = 'wave', flag = flag(18)},
  Waypoint = {id = 'waypoint', flag = flag(19)},
  Aggression = {id = 'aggression', flag = flag(20)},
  Attack = {id = 'attack', flag = flag(21)},
  Dash = {id = 'dash', flag = flag(22)},
  Platform = {id = 'platform', flag = flag(23)},
  Trigger = {id = 'trigger', flag = flag(24)}
}

return constants
