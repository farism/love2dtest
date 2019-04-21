--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Respawn = exports.Respawn or {};
exports.Respawn.__index = exports.Respawn;
exports.Respawn.prototype = exports.Respawn.prototype or {};
exports.Respawn.prototype.__index = exports.Respawn.prototype;
exports.Respawn.prototype.constructor = exports.Respawn;
exports.Respawn.____super = Component;
setmetatable(exports.Respawn, exports.Respawn.____super);
setmetatable(exports.Respawn.prototype, exports.Respawn.____super.prototype);
exports.Respawn.new = function(...)
    local self = setmetatable({}, exports.Respawn.prototype);
    self:____constructor(...);
    return self;
end;
exports.Respawn.prototype.____constructor = function(self, waitTime)
    self._id = exports.Respawn._id;
    self._flag = Flag.Respawn;
    if waitTime == nil then
        waitTime = 0;
    end
    Component.prototype.____constructor(self);
    self.waitTime = waitTime;
end;
exports.Respawn._id = "Respawn";
exports.Respawn._flag = Flag.Respawn;
return exports;
