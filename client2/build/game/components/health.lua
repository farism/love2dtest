--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.Health = exports.Health or {};
exports.Health.__index = exports.Health;
exports.Health.prototype = exports.Health.prototype or {};
exports.Health.prototype.__index = exports.Health.prototype;
exports.Health.prototype.constructor = exports.Health;
exports.Health.new = function(...)
    local self = setmetatable({}, exports.Health.prototype);
    self:____constructor(...);
    return self;
end;
exports.Health.prototype.____constructor = function(self, hitpoints, armor)
    self._id = exports.Health._id;
    self._flag = ComponentFlag.Health;
    if hitpoints == nil then
        hitpoints = 0;
    end
    if armor == nil then
        armor = 0;
    end
    self.hitpoints = hitpoints;
    self.armor = armor;
end;
exports.Health._id = "Health";
exports.Health._flag = ComponentFlag.Health;
return exports;
