--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.AbilityType = {};
exports.AbilityType.Throw = "throw";
exports.AbilityType.throw = "Throw";
exports.AbilityType.Dash = "dash";
exports.AbilityType.dash = "Dash";
exports.AbilityType.Grapple = "grapple";
exports.AbilityType.grapple = "Grapple";
exports.AbilityType.Dig = "dig";
exports.AbilityType.dig = "Dig";
exports.AbilityType.Shoot = "shoot";
exports.AbilityType.shoot = "Shoot";
exports.AbilityType.Slash = "slash";
exports.AbilityType.slash = "Slash";
exports.AbilityType.Stab = "stab";
exports.AbilityType.stab = "Stab";
exports.AbilityType.Ambush = "ambush";
exports.AbilityType.ambush = "Ambush";
exports.AbilityType.Taser = "taser";
exports.AbilityType.taser = "Taser";
local defineAbility;
defineAbility = function(____, cooldown, duration, castspeed, enabled)
    if cooldown == nil then
        cooldown = 0;
    end
    if duration == nil then
        duration = 0;
    end
    if castspeed == nil then
        castspeed = 0;
    end
    if enabled == nil then
        enabled = true;
    end
    return {cooldown = cooldown, duration = duration, castspeed = castspeed, enabled = enabled, activated = false, timers = {}};
end;
exports.Abilities = exports.Abilities or {};
exports.Abilities.__index = exports.Abilities;
exports.Abilities.prototype = exports.Abilities.prototype or {};
exports.Abilities.prototype.__index = exports.Abilities.prototype;
exports.Abilities.prototype.constructor = exports.Abilities;
exports.Abilities.new = function(...)
    local self = setmetatable({}, exports.Abilities.prototype);
    self:____constructor(...);
    return self;
end;
exports.Abilities.prototype.____constructor = function(self)
    self._id = exports.Abilities._id;
    self._flag = ComponentFlag.Abilities;
    self.reset = function(____)
        for key in pairs(self.abilities) do
            do
                self.abilities[key].activated = false;
                self.abilities[key].timers = {};
            end
            ::__continue3::
        end
    end;
    self.setCooldown = function(____, ability, cooldown)
        self.abilities[ability].cooldown = cooldown;
    end;
    self.setDuration = function(____, ability, duration)
        self.abilities[ability].duration = duration;
    end;
    self.setCastspeed = function(____, ability, castspeed)
        self.abilities[ability].castspeed = castspeed;
    end;
    self.setEnabled = function(____, ability, enabled)
        self.abilities[ability].enabled = enabled;
    end;
    self.setActivated = function(____, ability, activated)
        self.abilities[ability].activated = activated;
    end;
    self.abilities = {[exports.AbilityType.Throw] = defineAbility(nil, 0.5, 0, 0), [exports.AbilityType.Dash] = defineAbility(nil, 0.5, 0, 0), [exports.AbilityType.Grapple] = defineAbility(nil, 1, 0, 0), [exports.AbilityType.Dig] = defineAbility(nil, 1, 1, 0), [exports.AbilityType.Shoot] = defineAbility(nil, 3, 0, 1.5, false), [exports.AbilityType.Slash] = defineAbility(nil, 3, 0, 1, false), [exports.AbilityType.Stab] = defineAbility(nil, 3, 0, 1, false), [exports.AbilityType.Ambush] = defineAbility(nil, 3, 0, 1, false), [exports.AbilityType.Taser] = defineAbility(nil, 3, 0, 1, false)};
end;
exports.Abilities._id = "Abilities";
exports.Abilities._flag = ComponentFlag.Abilities;
return exports;
