local constants = require 'game.components.constants'

local Ability = {
  _meta = constants.Ability
}

local function ability(timers)
  return {
    active = false,
    cooldown = timers.cooldown or 0,
    duration = timers.duration or 0
  }
end

function Ability.new(id, timers)
  timers = timers or {}

  return {
    _meta = Ability._meta,
    id = id,
    abilities = {
      throw = ability(timers.throw or {cooldown = 0.5, duration = 0}),
      dash = ability(timers.dash or {cooldown = 1, duration = 0.2}),
      grapple = ability(timers.grapple or {cooldown = 1, duration = 0}),
      dig = ability(timers.dig or {cooldown = 1, duration = 1})
    }
  }
end

return Ability
