local constants = require 'src.game.components.constants'

local Health = {
  _meta = constants.Health
}

function Health.new(id, hitpoints, armor)
  return {
    _meta = Health._meta,
    id = id,
    hitpoints = hitpoints or 0,
    armor = armor or 0
  }
end

return Health
