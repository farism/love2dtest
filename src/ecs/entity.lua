local Entity = {}

function Entity:new(id, manager, meta)
  local entity = {
    id = id,
    manager = manager,
    components = 0,
    systems = 0,
    meta = meta or {}
  }

  function entity:has(cmp)
    return bit.band(self.components, cmp._meta.flag) == cmp._meta.flag
  end

  function entity:as(cmp)
    return self.manager:getComponent(self, cmp)
  end

  function entity:addComponent(cmp)
    if self:has(cmp) then
      print('entity:' .. self.id .. ' already has ' .. cmp._meta.id)
      return
    end

    self.components = bit.bxor(self.components, cmp._meta.flag)
  end

  function entity:removeComponent(cmp)
    if not self:has(cmp) then
      print('entity:' .. self.id .. ' does not have ' .. cmp._meta.id)
      return
    end

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
