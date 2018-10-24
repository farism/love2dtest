local constants = require 'game.components.constants'

local Input = {
  _meta = constants.Input
}

function Input.new(id)
  return {
    _meta = Input._meta,
    id = id,
    jumps = 0,
    left = false,
    right = false,
    swing = false,
    shoot = false,
    grapple = false,
    dig = false
  }
end

return Input
