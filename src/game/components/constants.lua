local flag = require('utils/flag')

local constants = {}

constants = {
  Player = {
    id = 'player',
    flag = flag(0)
  },
  Sprite = {
    id = 'sprite',
    flag = flag(1)
  },
  Spritesheet = {
    id = 'spritesheet',
    flag = flag(2)
  },
  Movement = {
    id = 'movement',
    flag = flag(3)
  },
  Projectile = {
    id = 'projectile',
    flag = flag(4)
  }
}

return constants
