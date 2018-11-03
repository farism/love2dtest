local flag = require 'game.utils.flag'

local constants = {
  Input = {id = 'input', flag = flag(0)},
  Movement = {id = 'movement', flag = flag(1)},
  Music = {id = 'music', flag = flag(2)},
  Fixture = {id = 'fixture', flag = flag(4)},
  Player = {id = 'player', flag = flag(6)},
  Position = {id = 'position', flag = flag(3)},
  Projectile = {id = 'projectile', flag = flag(7)},
  Sound = {id = 'movement', flag = flag(8)},
  Sprite = {id = 'sprite', flag = flag(9)},
  Spritesheet = {id = 'spritesheet', flag = flag(10)},
  Velocity = {id = 'velocity', flag = flag(11)},
  Checkpoint = {id = 'checkpoint', flag = flag(5)},
  Snare = {id = 'snare', flag = flag(12)},
  Upgrades = {id = 'upgrades', flag = flag(13)},
  Ability = {id = 'ability', flag = flag(14)},
  Timer = {id = 'timer', flag = flag(15)},
  Container = {id = 'container', flag = flag(18)},
  Waypoint = {id = 'waypoint', flag = flag(19)},
  Health = {id = 'health', flag = flag(20)},
  Damage = {id = 'damage', flag = flag(21)},
  Sine = {id = 'sine', flag = flag(22)},
  Animation = {id = 'animation', flag = flag(23)}
}

return constants
