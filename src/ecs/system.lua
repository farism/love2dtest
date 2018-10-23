local Aspect = require 'ecs.Aspect'

local System = {}

local function noop()
end

function System:new(id, aspect, input, update, draw)
  local input = input or noop
  local update = update or noop
  local draw = draw or noop

  local system = {
    id = id,
    aspect = aspect or Aspect:new(),
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

  function system:input(key, scancode, isRepeat, isPressed)
    input(key, scancode, isRepeat, isPressed, self.entities)
  end

  function system:update(dt)
    update(dt, self.entities)
  end

  function system:draw()
    draw(self.entities)
  end

  return system
end

return System
