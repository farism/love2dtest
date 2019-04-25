--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Snare = exports.Snare or {};
exports.Snare.__index = exports.Snare;
exports.Snare.prototype = exports.Snare.prototype or {};
exports.Snare.prototype.__index = exports.Snare.prototype;
exports.Snare.prototype.constructor = exports.Snare;
exports.Snare.new = function(...)
    local self = setmetatable({}, exports.Snare.prototype);
    self:____constructor(...);
    return self;
end;
exports.Snare.prototype.____constructor = function(self, strength)
    self._id = exports.Snare._id;
    self._flag = Flag.Snare;
    if strength == nil then
        strength = 0;
    end
    self.strength = strength;
end;
exports.Snare._id = "Snare";
exports.Snare._flag = Flag.Snare;
return exports;
