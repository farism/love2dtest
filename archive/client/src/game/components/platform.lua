local constants = require 'src.game.components.constants'

local Platform = {
  _meta = constants.Platform
}

function Platform.new(id, fall, initialX, initialY)
  return {
    _meta = Platform._meta,
    id = id,
    fall = fall or 0, -- time after contact that platform will fall
    initialX = initialX or 0,
    initialY = initialY or 0
  }
end

return Platform
