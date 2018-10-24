local System = require 'ecs.system'

local IntervalSystem = {}

local function noop()
end

function IntervalSystem:new(id, aspect, interval, onUpdate)
  local onUpdate = onUpdate or noop

  local system = System:new(id, aspect)

  system.interval = interval or 1
  system.elapsed = 0

  function system:update(dt)
    local elapsed = self.elapsed + dt

    if (elapsed >= self.interval) then
      self.elapsed = elapsed - self.interval
      onUpdate(self.entities)
    else
      self.elapsed = elapsed
    end
  end

  return system
end

return IntervalSystem
