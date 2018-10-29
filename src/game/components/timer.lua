local constants = require 'game.components.constants'

local Timer = {
  _meta = constants.Timer
}

function Timer.new(id, length)
  return {
    _meta = Timer._meta,
    id = id,
    timers = {}
  }
end

return Timer
