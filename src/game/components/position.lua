local constants = require 'game.components.constants'

local Position = {
  _meta = constants.Position
}

function Position.new(id, x, y)
  return {
    _meta = Position._meta,
    id = id,
    x = x or 0,
    y = y or 0
  }
end

return Position
