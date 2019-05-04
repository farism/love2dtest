--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.AbilityType = {}
____exports.AbilityType.Throw = "throw"
____exports.AbilityType.throw = "Throw"
____exports.AbilityType.Dash = "dash"
____exports.AbilityType.dash = "Dash"
____exports.AbilityType.Grapple = "grapple"
____exports.AbilityType.grapple = "Grapple"
____exports.AbilityType.Dig = "dig"
____exports.AbilityType.dig = "Dig"
____exports.AbilityType.Shoot = "shoot"
____exports.AbilityType.shoot = "Shoot"
____exports.AbilityType.Slash = "slash"
____exports.AbilityType.slash = "Slash"
____exports.AbilityType.Stab = "stab"
____exports.AbilityType.stab = "Stab"
____exports.AbilityType.Ambush = "ambush"
____exports.AbilityType.ambush = "Ambush"
____exports.AbilityType.Taser = "taser"
____exports.AbilityType.taser = "Taser"
local defineAbility
defineAbility = function(____, cooldown, duration, castspeed, enabled)
    if cooldown == nil then
        cooldown = 0
    end
    if duration == nil then
        duration = 0
    end
    if castspeed == nil then
        castspeed = 0
    end
    if enabled == nil then
        enabled = true
    end
    return {
        activated = false,
        castspeed = castspeed,
        cooldown = cooldown,
        duration = duration,
        enabled = enabled,
        timers = {},
    }
end
____exports.Abilities = {}
local Abilities = ____exports.Abilities
Abilities.name = "Abilities"
Abilities.__index = Abilities
Abilities.prototype = {}
Abilities.prototype.__index = Abilities.prototype
Abilities.prototype.constructor = Abilities
function Abilities.new(...)
    local self = setmetatable({}, Abilities.prototype)
    self:____constructor(...)
    return self
end
function Abilities.prototype.____constructor(self)
    self._id = ____exports.Abilities._id
    self._flag = ComponentFlag.Abilities
    self.reset = function()
    end
    self.setCooldown = function(____, ability, cooldown)
        self.abilities[ability].cooldown = cooldown
    end
    self.setDuration = function(____, ability, duration)
        self.abilities[ability].duration = duration
    end
    self.setCastspeed = function(____, ability, castspeed)
        self.abilities[ability].castspeed = castspeed
    end
    self.setEnabled = function(____, ability, enabled)
        self.abilities[ability].enabled = enabled
    end
    self.setActivated = function(____, ability, activated)
        self.abilities[ability].activated = activated
    end
    self.abilities = {
        [____exports.AbilityType.Throw] = defineAbility(nil, 0.5, 0, 0),
        [____exports.AbilityType.Dash] = defineAbility(nil, 1, 0.1, 0),
        [____exports.AbilityType.Grapple] = defineAbility(nil, 1, 0, 0),
        [____exports.AbilityType.Dig] = defineAbility(nil, 1, 1, 0),
        [____exports.AbilityType.Shoot] = defineAbility(nil, 3, 0, 1.5, false),
        [____exports.AbilityType.Slash] = defineAbility(nil, 3, 0, 1, false),
        [____exports.AbilityType.Stab] = defineAbility(nil, 3, 0, 1, false),
        [____exports.AbilityType.Ambush] = defineAbility(nil, 3, 0, 1, false),
        [____exports.AbilityType.Taser] = defineAbility(nil, 3, 0, 1, false),
    }
end
Abilities._id = "Abilities"
Abilities._flag = ComponentFlag.Abilities
return ____exports
