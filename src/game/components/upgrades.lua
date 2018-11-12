local constants = require 'game.components.constants'

local Upgrades = {
  _meta = constants.Upgrades
}

function Upgrades.new(id, passive, throw, dash, grapple, dig)
  return {
    _meta = Upgrades._meta,
    id = id,
    passive = passive or 0,
    throw = throw or 0,
    dash = dash or 0,
    grapple = grapple or 0,
    dig = dig or 0
  }
end

return Upgrades
