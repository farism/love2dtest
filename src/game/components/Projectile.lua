local constants = require 'game.components.constants'

local Projectile = {
  _meta = constants.Projectile
}

function Projectile:new(id, alias)
  return {
    _meta = Projectile._meta,
    id = id,
    alias = alias
  }
end

return Projectile
