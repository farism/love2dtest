--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.Movement = exports.Movement or {};
exports.Movement.__index = exports.Movement;
exports.Movement.prototype = exports.Movement.prototype or {};
exports.Movement.prototype.__index = exports.Movement.prototype;
exports.Movement.prototype.constructor = exports.Movement;
exports.Movement.new = function(...)
    local self = setmetatable({}, exports.Movement.prototype);
    self:____constructor(...);
    return self;
end;
exports.Movement.prototype.____constructor = function(self)
    self._id = exports.Movement._id;
    self._flag = ComponentFlag.Movement;
    self.direction = "right";
    self.left = false;
    self.right = false;
    self.jump = false;
    self.jumpCount = 0;
end;
exports.Movement._id = "Movement";
exports.Movement._flag = ComponentFlag.Movement;
return exports;
