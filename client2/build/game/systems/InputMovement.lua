--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_GameObject = require("game.components.GameObject");
local GameObject = __TSTL_GameObject.GameObject;
local __TSTL_Input = require("game.components.Input");
local Input = __TSTL_Input.Input;
local __TSTL_Movement = require("game.components.Movement");
local Movement = __TSTL_Movement.Movement;
local __TSTL_Position = require("game.components.Position");
local Position = __TSTL_Position.Position;
local __TSTL_Respawn = require("game.components.Respawn");
local Respawn = __TSTL_Respawn.Respawn;
exports.InputMovementSystem = exports.InputMovementSystem or {};
exports.InputMovementSystem.__index = exports.InputMovementSystem;
exports.InputMovementSystem.prototype = exports.InputMovementSystem.prototype or {};
exports.InputMovementSystem.prototype.__index = exports.InputMovementSystem.prototype;
exports.InputMovementSystem.prototype.constructor = exports.InputMovementSystem;
exports.InputMovementSystem.____super = System;
setmetatable(exports.InputMovementSystem, exports.InputMovementSystem.____super);
setmetatable(exports.InputMovementSystem.prototype, exports.InputMovementSystem.____super.prototype);
exports.InputMovementSystem.new = function(...)
    local self = setmetatable({}, exports.InputMovementSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.InputMovementSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.InputMovementSystem._id;
    self._flag = exports.InputMovementSystem._flag;
    self._aspect = exports.InputMovementSystem._aspect;
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local gameObject = entity:as(GameObject);
            local movement = entity:as(Movement);
            if (not gameObject) or (not movement) then
                return;
            end
            local body = gameObject.fixture:getBody();
            local velocityX, velocityY = body:getLinearVelocity();
            local newVelocityX = 0;
            local newVelocityY = velocityY;
            if movement.left then
                newVelocityX = -300;
            elseif movement.right then
                newVelocityX = 300;
            end
            if movement.jump and (movement.jumpCount < 2) then
                newVelocityY = -1000;
                movement.jump = false;
                movement.jumpCount = movement.jumpCount + 1;
                print(movement.jumpCount);
            end
            body:setLinearVelocity(newVelocityX, newVelocityY);
        end);
    end;
end;
exports.InputMovementSystem._id = "InputMovement";
exports.InputMovementSystem._flag = SystemFlag.InputMovement;
exports.InputMovementSystem._aspect = Aspect.new({GameObject, Input, Movement, Position});
return exports;
