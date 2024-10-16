local lume = require 'src.vendor.lume'

local Aspect = {}

local function flags(components)
  return lume.reduce(
    components,
    function(acc, component)
      return bit.bxor(acc, component._meta.flag)
    end,
    0
  )
end

function Aspect.new(all, none, one)
  local aspect = {
    all = flags(all or {}),
    none = flags(none or {}),
    one = flags(one or {})
  }

  function aspect:check(entity)
    local all = bit.bor(self.all, entity.components) == entity.components
    local none = bit.band(self.none, entity.components) == 0
    local one = bit.band(self.one, entity.components) ~= 0

    return (one or all) and none
  end

  return aspect
end

function Aspect:always()
  local aspect = {}

  function aspect:check()
    return true
  end

  return aspect
end

function Aspect:never()
  local aspect = {}

  function aspect:check()
    return false
  end

  return aspect
end

return Aspect
