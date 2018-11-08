local Entity = {}

function Entity:new(id, manager, meta)
  local entity = {
    id = id,
    manager = manager,
    components = 0,
    systems = 0,
    meta = meta or {}
  }

  function entity:destroy()
    self.manager:removeEntity(self)
  end

  function entity:has(cmp)
    return bit.band(self.components, cmp._meta.flag) == cmp._meta.flag
  end

  function entity:as(cmp)
    return self.manager:getComponent(self, cmp)
  end

  function entity:addComponent(cmp)
    return self.manager:addComponent(self, cmp)
  end

  function entity:removeComponent(cmp)
    return self.manager:removeComponent(self, cmp)
  end

  function entity:setFlag(cmp)
    if self:has(cmp) then
      print('entity:' .. self.id .. ' already has ' .. cmp._meta.id)
      return
    end

    self.components = bit.bxor(self.components, cmp._meta.flag)
  end

  function entity:clearFlag(cmp)
    if not self:has(cmp) then
      print('entity:' .. self.id .. ' does not have ' .. cmp._meta.id)
      return
    end

    self.components = bit.band(self.components, bit.bnot(cmp._meta.flag))
  end

  return entity
end

return Entity
