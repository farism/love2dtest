local constants = require 'game.components.constants'

local Ability = {
  _meta = constants.Ability
}

function Ability.new(id)
  local ability = {
    _meta = Ability._meta,
    id = id,
    throw = false,
    dash = false,
    grapple = false,
    dig = false
  }

  return ability
end

return Ability
