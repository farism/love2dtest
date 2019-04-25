--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Checkpoint = exports.Checkpoint or {};
exports.Checkpoint.__index = exports.Checkpoint;
exports.Checkpoint.prototype = exports.Checkpoint.prototype or {};
exports.Checkpoint.prototype.__index = exports.Checkpoint.prototype;
exports.Checkpoint.prototype.constructor = exports.Checkpoint;
exports.Checkpoint.new = function(...)
    local self = setmetatable({}, exports.Checkpoint.prototype);
    self:____constructor(...);
    return self;
end;
exports.Checkpoint.prototype.____constructor = function(self, hitpoints)
    self._id = exports.Checkpoint._id;
    self._flag = Flag.Checkpoint;
    if hitpoints == nil then
        hitpoints = 0;
    end
    self.hitpoints = hitpoints;
end;
exports.Checkpoint._id = "Checkpoint";
exports.Checkpoint._flag = Flag.Checkpoint;
return exports;
