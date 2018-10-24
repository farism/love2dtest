local Aspect = require 'ecs.Aspect'

local System = {}

function System:new(id, aspect)
  local system = {
    id = id,
    aspect = aspect or Aspect:new(),
    entities = {},
    paused = false
  }

  setmetatable(system, self)
  self.__index = self

  return system
end

function System:add(entity)
  self.entities[entity.id] = entity
end

function System:remove(entity)
  self.entities[entity.id] = nil
end

function System:pause()
  self.paused = true
end

function System:resume()
  self.paused = false
end

function System:input(key, scancode, isRepeat, isPressed)
end

function System:update(dt)
end

function System:draw()
end

return System
