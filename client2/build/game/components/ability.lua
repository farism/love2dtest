--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
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
exports.Abilities.____super = Component;
setmetatable(exports.Abilities, exports.Abilities.____super);
setmetatable(exports.Abilities.prototype, exports.Abilities.____super.prototype);
exports.Abilities.new = function(...)
    local self = setmetatable({}, exports.Abilities.prototype);
    self:____constructor(...);
    return self;
end;
exports.Abilities.prototype.____constructor = function(self)
    self._id = exports.Abilities._id;
    self._flag = Flag.Abilities;
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
    Component.prototype.____constructor(self);
    self.abilities = {throw = defineAbility(nil, 0.5, 0, 0), dash = defineAbility(nil, 0.5, 0, 0), grapple = defineAbility(nil, 1, 0, 0), dig = defineAbility(nil, 1, 1, 0), shoot = defineAbility(nil, 3, 0, 1.5, false), slash = defineAbility(nil, 3, 0, 1, false), stab = defineAbility(nil, 3, 0, 1, false), ambush = defineAbility(nil, 3, 0, 1, false), taser = defineAbility(nil, 3, 0, 1, false)};
end;
exports.Abilities._id = "Abilities";
exports.Abilities._flag = Flag.Abilities;
return exports;
