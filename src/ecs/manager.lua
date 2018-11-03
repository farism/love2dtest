local Entity = require 'ecs.entity'

local Manager = {}

function Manager:new(world)
  local manager = {
    world = world,
    factory = nil,
    entities = {},
    components = {},
    systems = {},
    nextid = 1
  }

  function manager:setFactory(factory)
    self.factory = factory
  end

  -- managing entities

  function manager:nextId()
    local id = manager.nextid

    manager.nextid = manager.nextid + 1

    return id
  end

  function manager:newEntity(id)
    local entity = Entity:new(id or self:nextId(), self)

    self:addEntity(entity)

    return entity
  end

  function manager:getEntity(id)
    return self.entities[id]
  end

  function manager:addEntity(entity)
    self:check(entity)

    self.entities[entity.id] = entity
  end

  function manager:removeEntity(entity)
    for _, sys in pairs(self.systems) do
      sys:remove(entity)
    end

    self:removeComponents(entity)
    self.components[entity.id] = nil
    self.entities[entity.id] = nil
  end

  -- managing components

  function manager:getComponent(entity, cmp)
    return (self.components[entity.id] or {})[cmp._meta.id]
  end

  function manager:setComponent(entity, cmp, value)
    local components = self.components[entity.id] or {}
    components[cmp._meta.id] = value
    self.components[entity.id] = components
  end

  function manager:addComponent(entity, cmp)
    entity:addComponent(cmp)
    self:setComponent(entity, cmp, cmp)
    self:check(entity)
  end

  function manager:removeComponent(entity, cmp)
    entity:removeComponent(cmp)
    self:setComponent(entity, cmp, nil)
    self:check(entity)
  end

  function manager:removeComponents(entity)
    for _, component in pairs(self.components[entity.id]) do
      if (component.destroy) then
        component:destroy()
      end

      self:setComponent(entity, component, nil)
    end
  end

  -- managing systems

  function manager:addSystem(sys)
    for _, entity in pairs(self.entities) do
      sys:check(entity)
    end

    sys:setManager(self)

    table.insert(self.systems, sys)
  end

  function manager:removeSystem(sys)
    local position = nil

    for i, system in self.systems do
      if system.id == sys then
        position = i
      end
    end

    table.remove(self.systems, position)
  end

  function manager:check(entity)
    for _, sys in pairs(self.systems) do
      sys:check(entity)
    end
  end

  function manager:keyboard(key, scancode, isrepeat, ispressed)
    for _, sys in pairs(self.systems) do
      sys:keyboard(key, scancode, isrepeat, ispressed)
    end
  end

  function manager:mouse(x, y, button, istouch, presses)
    for _, sys in pairs(self.systems) do
      sys:mouse(x, y, button, istouch, presses)
    end
  end

  function manager:collision(a, b, contact)
    for _, sys in pairs(self.systems) do
      sys:collision(a, b, contact, self.world)
    end
  end

  function manager:update(dt)
    for _, sys in pairs(self.systems) do
      sys:update(dt)
    end
  end

  function manager:draw()
    for _, sys in pairs(self.systems) do
      sys:draw()
    end
  end

  return manager
end

return Manager
