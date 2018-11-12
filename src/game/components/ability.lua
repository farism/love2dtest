local constants = require 'game.components.constants'

local Ability = {
  _meta = constants.Ability
}

local function ability(params)
  return {
    cooldown = params.cd or 0,
    duration = params.dur or 0,
    castspeed = params.speed or 0,
    enabled = params.enabled == nil and true or params.enabled,
    activated = false,
    timers = {}
  }
end

function Ability.new(id, timers)
  timers = timers or {}

  local ability = {
    _meta = Ability._meta,
    id = id,
    abilities = {
      -- player
      throw = ability({cd = 0.5, dur = 0, speed = 0}),
      dash = ability({cd = 1, dur = 0.2, speed = 0}),
      grapple = ability({cd = 1, dur = 0, speed = 0}),
      dig = ability({cd = 1, dur = 1, speed = 0}),
      -- mob, only enable one at a time
      shoot = ability({cd = 3, dur = 0, speed = 1.5, enabled = false}),
      slash = ability({cd = 3, dur = 0, speed = 1, enabled = false}),
      stab = ability({cd = 3, dur = 0, speed = 1, enabled = false})
    }
  }

  function ability:reset()
    for _, ability in pairs(self.abilities) do
      ability.activated = false
      ability.timers = {}
    end

    return self
  end

  function ability:setCooldown(ability, cooldown)
    self.abilities[ability].cooldown = cooldown

    return self
  end

  function ability:setDuration(ability, duration)
    self.abilities[ability].duration = duration

    return self
  end

  function ability:setCastspeed(ability, castspeed)
    self.abilities[ability].castspeed = castspeed

    return self
  end

  function ability:setEnabled(ability, enabled)
    self.abilities[ability].enabled = enabled

    return self
  end

  function ability:setActivated(ability, activated)
    self.abilities[ability].activated = activated

    return self
  end

  return ability
end

return Ability
