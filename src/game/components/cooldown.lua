local constants = require 'game.components.constants'

local Cooldown = {
  _meta = constants.Cooldown
}

function Cooldown.new(id)
  local cooldown = {
    _meta = Cooldown._meta,
    id = id,
    timers = {
      throw = 0,
      dash = 0,
      grapple = 0,
      dig = 0
    }
  }

  return cooldown
end

return Cooldown
