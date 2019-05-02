--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_Input = require("game.components.Input");
local Input = __TSTL_Input.Input;
local __TSTL_Movement = require("game.components.Movement");
local Movement = __TSTL_Movement.Movement;
local INPUTS = {left = "a", right = "d", jump = "space", throw = "j", dash = "k"};
exports.InputSystem = exports.InputSystem or {};
exports.InputSystem.__index = exports.InputSystem;
exports.InputSystem.prototype = exports.InputSystem.prototype or {};
exports.InputSystem.prototype.__index = exports.InputSystem.prototype;
exports.InputSystem.prototype.constructor = exports.InputSystem;
exports.InputSystem.____super = System;
setmetatable(exports.InputSystem, exports.InputSystem.____super);
setmetatable(exports.InputSystem.prototype, exports.InputSystem.____super.prototype);
exports.InputSystem.new = function(...)
    local self = setmetatable({}, exports.InputSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.InputSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.InputSystem._id;
    self._flag = exports.InputSystem._flag;
    self._aspect = exports.InputSystem._aspect;
    self.keyboard = function(____, key, scancode, isRepeat, isPressed)
        print({key = key, scancode = scancode, isRepeat = isRepeat, isPressed = isPressed});
    end;
end;
exports.InputSystem._id = "Input";
exports.InputSystem._flag = SystemFlag.Input;
exports.InputSystem._aspect = Aspect.new({Input, Movement});
return exports;
