local constants = require 'game.components.constants'

local Movement = {
  _meta = constants.Movement
}

function Movement.new(id)
  local movement = {
    _meta = Movement._meta,
    id = id,
    direction = 'right', -- left or right
    left = false,
    right = false,
    jump = false,
    jumpCount = 0,
    aim = 0
  }

  return movement
end

return Movement
