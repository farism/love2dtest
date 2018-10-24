local constants = require 'game.components.constants'

local Projectile = {
  _meta = constants.Projectile
}

function Projectile.new(id)
  return {
    _meta = Projectile._meta,
    id = id
  }
end

return Projectile
