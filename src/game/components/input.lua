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
    shoot = false,
    shootCooldown = 0,
    dash = false,
    dashCooldown = 0,
    grapple = false,
    grappleCooldown = 0,
    dig = false,
    digCooldown = 0
  }
end

return Input
