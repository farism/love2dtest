--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.Damage = exports.Damage or {};
exports.Damage.__index = exports.Damage;
exports.Damage.prototype = exports.Damage.prototype or {};
exports.Damage.prototype.__index = exports.Damage.prototype;
exports.Damage.prototype.constructor = exports.Damage;
exports.Damage.new = function(...)
    local self = setmetatable({}, exports.Damage.prototype);
    self:____constructor(...);
    return self;
end;
exports.Damage.prototype.____constructor = function(self, hitpoints)
    self._id = exports.Damage._id;
    self._flag = ComponentFlag.Damage;
    if hitpoints == nil then
        hitpoints = 0;
    end
    self.hitpoints = hitpoints;
end;
exports.Damage._id = "Damage";
exports.Damage._flag = ComponentFlag.Damage;
return exports;
