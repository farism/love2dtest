local constants = require 'game.components.constants'

local Velocity = {
  _meta = constants.Velocity
}

function Velocity:new(id, x, y)
  return {
    _meta = Velocity._meta,
    id = id,
    x = x or 0,
    y = y or 0
  }
end

return Velocity
