local flag = require 'utils.flag'

local constants = {}

constants = {
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
  Velocity = {id = 'velocity', flag = flag(11)}
}

return constants
