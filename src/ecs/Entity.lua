local Entity = {}

function Entity:new(id, manager)
  local entity = {
    id = id,
    manager = manager,
    components = 0,
    systems = 0
  }

  function entity:as(cmp)
    return self.manager:getComponent(self, cmp)
  end

  function entity:addComponent(cmp)
    self.components = bit.bxor(self.components, cmp._meta.flag)
  end

  function entity:removeComponent(cmp)
    self.components = bit.band(self.components, bit.bnot(cmp._meta.flag))
  end

  function entity:addSystem(sys)
    self.systems = bit.bxor(self.systems, system.flag)
  end

  function entity:removeSystem(sys)
    self.components = bit.band(self.systems, bit.bnot(sys.flag))
  end

  return entity
end

return Entity
