local constants = require 'game.components.constants'

local Timer = {
  _meta = constants.Timer
}

function Timer.new(id, length)
  local timer = {
    _meta = Timer._meta,
    id = id,
    timers = {}
  }

  function timer:get(key)
    local timers = self.timers[key] or {}
    self.timers[key] = timers

    return timers
  end

  return timer
end

return Timer
