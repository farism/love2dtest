local Aspect = require('ecs/Aspect')

local IntervalSystem = {}

local function noop()
end

function IntervalSystem:new(id, aspect, interval, input, update, draw)
  local input = input or noop
  local update = update or noop
  local draw = draw or noop

  local system = {
    id = id,
    aspect = aspect or Aspect:new(),
    interval = interval or 1,
    elapsed = 0,
    entities = {}
  }

  -- entity tracking

  function system:add(entity)
    self.entities[entity.id] = entity
  end

  function system:remove(entity)
    self.entities[entity.id] = nil
  end

  -- callbacks

  function system:input(key, scancode, isRepeat)
    input(key, scancode, isRepeat, isPressed, self.entities)
  end

  function system:update(dt)
    local elapsed = self.elapsed + dt

    if (elapsed >= self.interval) then
      self.elapsed = elapsed - self.interval
      update(self.entities)
    else
      self.elapsed = elapsed
    end
  end

  function system:draw()
    draw(self.entities)
  end

  return system
end

return IntervalSystem
