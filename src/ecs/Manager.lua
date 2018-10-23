local Entity = require('ecs/entity')

local Manager = {}

function Manager:new()
  local manager = {
    entities = {},
    components = {},
    systems = {},
    nextid = 1
  }

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
    self.entities[entity.id] = entity
  end

  function manager:removeEntity(entity)
    for _, sys in pairs(self.systems) do
      sys:remove(entity)
    end

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

  -- managing systems

  function manager:addSystem(sys)
    self.systems[sys.id] = sys
  end

  function manager:removeSystem(sys)
    self.systems[sys.id] = nil
  end

  function manager:check(entity)
    for _, sys in pairs(self.systems) do
      if sys.aspect:check(entity) then
        sys:add(entity)
      else
        sys:remove(entity)
      end
    end
  end

  function manager:input(key, scancode, isRepeat, isPressed)
    for _, sys in pairs(self.systems) do
      sys:input(key, scancode, isRepeat, isPressed)
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
