--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local NeverAspect = __TSTL_Aspect.NeverAspect;
local __TSTL_Movement = require("game.components.Movement");
local Movement = __TSTL_Movement.Movement;
local __TSTL_collision = require("game.utils.collision");
local check = __TSTL_collision.check;
local hasComponent = __TSTL_collision.hasComponent;
local isNotBodyType = __TSTL_collision.isNotBodyType;
local __TSTL_Player = require("game.components.Player");
local Player = __TSTL_Player.Player;
exports.JumpResetSystem = exports.JumpResetSystem or {};
exports.JumpResetSystem.__index = exports.JumpResetSystem;
exports.JumpResetSystem.prototype = exports.JumpResetSystem.prototype or {};
exports.JumpResetSystem.prototype.__index = exports.JumpResetSystem.prototype;
exports.JumpResetSystem.prototype.constructor = exports.JumpResetSystem;
exports.JumpResetSystem.____super = System;
setmetatable(exports.JumpResetSystem, exports.JumpResetSystem.____super);
setmetatable(exports.JumpResetSystem.prototype, exports.JumpResetSystem.____super.prototype);
exports.JumpResetSystem.new = function(...)
    local self = setmetatable({}, exports.JumpResetSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.JumpResetSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.JumpResetSystem._id;
    self._flag = exports.JumpResetSystem._flag;
    self._aspect = exports.JumpResetSystem._aspect;
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {hasComponent(nil, Player), isNotBodyType(nil, "dynamic")});
        if not result then
            return;
        end
        local player = unpack(result);
        local nx, ny = contact:getNormal();
        if ((nx == (-1)) or (nx == 1)) or (ny < 0) then
            local movement = player:as(Movement);
            if movement then
                movement.jumpCount = 0;
            end
        end
    end;
end;
exports.JumpResetSystem._id = "JumpReset";
exports.JumpResetSystem._flag = SystemFlag.JumpReset;
exports.JumpResetSystem._aspect = NeverAspect.new();
return exports;
