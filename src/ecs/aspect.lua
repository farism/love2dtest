local Aspect = {}

local function flags(components)
  local value = 0

  for _, component in pairs(components) do
    value = bit.bxor(value, component._meta.flag)
  end

  return value
end

function Aspect:new(all, none, one)
  local aspect = {
    all = flags(all or {}),
    none = flags(none or {}),
    one = flags(one or {})
  }

  function aspect:check(entity)
    local all = bit.bor(self.all, entity.components) == entity.components
    local none = bit.band(self.none, entity.components) == 0
    -- local one = bit.band(aspect.one, entity.components) ~= 0

    return all and none
    -- and one
  end

  return aspect
end

function Aspect:any()
  local aspect = {}

  function aspect:check()
    return true
  end

  return aspect
end

return Aspect
