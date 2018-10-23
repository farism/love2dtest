local constants = require('game/components/constants')

local Spritesheet = {
  _meta = constants.Spritesheet
}

function Spritesheet:new(id, file, x, y, width, height, frames)
  return {
    _meta = Spritesheet._meta,
    id = id,
    file = file,
    x = x or 0,
    y = y or 0,
    width = width or 32,
    height = height or 32,
    frames = frames or 1,
    current = 1,
    elapsed = 0
  }
end

return Spritesheet
