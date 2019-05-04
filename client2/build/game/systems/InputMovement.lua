--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Input = require("game.components.Input")
local Input = __TSTL_Input.Input
local __TSTL_Movement = require("game.components.Movement")
local Movement = __TSTL_Movement.Movement
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local __TSTL_Respawn = require("game.components.Respawn")
local Respawn = __TSTL_Respawn.Respawn
____exports.InputMovementSystem = {}
local InputMovementSystem = ____exports.InputMovementSystem
InputMovementSystem.name = "InputMovementSystem"
InputMovementSystem.__index = InputMovementSystem
InputMovementSystem.prototype = {}
InputMovementSystem.prototype.__index = InputMovementSystem.prototype
InputMovementSystem.prototype.constructor = InputMovementSystem
InputMovementSystem.____super = System
setmetatable(InputMovementSystem, InputMovementSystem.____super)
setmetatable(InputMovementSystem.prototype, InputMovementSystem.____super.prototype)
function InputMovementSystem.new(...)
    local self = setmetatable({}, InputMovementSystem.prototype)
    self:____constructor(...)
    return self
end
function InputMovementSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.InputMovementSystem._id
    self._flag = ____exports.InputMovementSystem._flag
    self._aspect = ____exports.InputMovementSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local gameObject = entity:as(GameObject)
            local movement = entity:as(Movement)
            if not gameObject or not movement then
                return
            end
            local body = gameObject.fixture:getBody()
            local velocityX, velocityY = body:getLinearVelocity()
            local newVelocityX = 0
            local newVelocityY = velocityY
            if movement.left then
                newVelocityX = -300
            elseif movement.right then
                newVelocityX = 300
            end
            if movement.jump and movement.jumpCount < 2 then
                newVelocityY = -1000
                movement.jump = false
                movement.jumpCount = movement.jumpCount + 1
            end
            body:setLinearVelocity(newVelocityX, newVelocityY)
        end)
    end
end
InputMovementSystem._id = "InputMovement"
InputMovementSystem._flag = SystemFlag.InputMovement
InputMovementSystem._aspect = Aspect.new({
    GameObject,
    Input,
    Movement,
    Position,
}, {Respawn})
return ____exports
