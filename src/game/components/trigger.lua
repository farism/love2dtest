local constants = require 'game.components.constants'

local Trigger = {
  _meta = constants.Trigger
}

local types = {
  SPAWN = 'spawn'
}

local function noop()
end

function Trigger.new(id, type, action)
  return {
    _meta = Trigger._meta,
    id = id,
    type = type or types.SPAWN,
    action = action or noop,
    activated = false,
    executed = false
  }
end

return Trigger
