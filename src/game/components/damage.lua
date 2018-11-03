local constants = require 'game.components.constants'

local Damage = {
  _meta = constants.Damage
}

function Damage.new(id, hitpoints)
  return {
    _meta = Damage._meta,
    id = id,
    hitpoints = hitpoints or 0
  }
end

return Damage
