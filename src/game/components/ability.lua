local constants = require 'game.components.constants'

local Ability = {
  _meta = constants.Ability
}

local function ability(cooldown, duration)
  return {
    active = false,
    cooldown = cooldown,
    duration = duration
  }
end

function Ability.new(id)
  return {
    _meta = Ability._meta,
    id = id,
    abilities = {
      throw = ability(1, 0),
      dash = ability(1, 0.5),
      grapple = ability(1, 0),
      dig = ability(1, 1)
    }
  }
end

return Ability
