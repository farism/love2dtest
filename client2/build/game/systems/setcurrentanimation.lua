--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Animation = require("game.components.Animation")
local Animation = __TSTL_Animation.Animation
local __TSTL_Movement = require("game.components.Movement")
local Movement = __TSTL_Movement.Movement
____exports.SetCurrentAnimationSystem = {}
local SetCurrentAnimationSystem = ____exports.SetCurrentAnimationSystem
SetCurrentAnimationSystem.name = "SetCurrentAnimationSystem"
SetCurrentAnimationSystem.__index = SetCurrentAnimationSystem
SetCurrentAnimationSystem.prototype = {}
SetCurrentAnimationSystem.prototype.__index = SetCurrentAnimationSystem.prototype
SetCurrentAnimationSystem.prototype.constructor = SetCurrentAnimationSystem
SetCurrentAnimationSystem.____super = System
setmetatable(SetCurrentAnimationSystem, SetCurrentAnimationSystem.____super)
setmetatable(SetCurrentAnimationSystem.prototype, SetCurrentAnimationSystem.____super.prototype)
function SetCurrentAnimationSystem.new(...)
    local self = setmetatable({}, SetCurrentAnimationSystem.prototype)
    self:____constructor(...)
    return self
end
function SetCurrentAnimationSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.SetCurrentAnimationSystem._id
    self._flag = ____exports.SetCurrentAnimationSystem._flag
    self._aspect = ____exports.SetCurrentAnimationSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local animation = entity:as(Animation)
            local movement = entity:as(Movement)
            if not animation or not movement then
                return
            end
            local action = "stand"
            if movement.right or movement.left then
                action = "walk"
            end
            local newAnimation = tostring(action) .. "_" .. tostring(movement.direction)
        end)
    end
end
SetCurrentAnimationSystem._id = "SetCurrentAnimation"
SetCurrentAnimationSystem._flag = SystemFlag.SetCurrentAnimation
SetCurrentAnimationSystem._aspect = Aspect.new({
    Animation,
    Movement,
})
return ____exports
