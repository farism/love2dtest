local Aspect = require 'src.ecs.aspect'

local System = {}

function System:new(id, aspect)
  local system = {
    id = id,
    aspect = aspect or Aspect.new(),
    entities = {},
    manager = nil,
    paused = false
  }

  setmetatable(system, self)
  self.__index = self

  return system
end

function System:setManager(manager)
  self.manager = manager
end

function System:check(entity)
  if (self.aspect:check(entity)) then
    if not self.entities[entity.id] then
      self:onAdd(entity)
    end

    self:add(entity)
  else
    if self.entities[entity.id] then
      self:onRemove(entity)
    end

    self:remove(entity)
  end
end

function System:add(entity)
  self.entities[entity.id] = entity
end

function System:onAdd(entity)
end

function System:remove(entity)
  self.entities[entity.id] = nil
end

function System:onRemove(entity)
end

function System:pause()
  self.paused = true
end

function System:resume()
  self.paused = false
end

function System:keyboard(key, scancode, isrepeat, ispressed)
end

function System:mouse(x, y, button, istouch, presses)
end

function System:beginContact(a, b, contact)
end

function System:endContact(a, b, contact)
end

function System:update(dt)
end

function System:draw()
end

return System
