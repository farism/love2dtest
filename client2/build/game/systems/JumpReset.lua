--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local NeverAspect = __TSTL_Aspect.NeverAspect
local __TSTL_Movement = require("game.components.Movement")
local Movement = __TSTL_Movement.Movement
local __TSTL_collision = require("game.utils.collision")
local check = __TSTL_collision.check
local hasComponent = __TSTL_collision.hasComponent
local isNotBodyType = __TSTL_collision.isNotBodyType
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
____exports.JumpResetSystem = {}
local JumpResetSystem = ____exports.JumpResetSystem
JumpResetSystem.name = "JumpResetSystem"
JumpResetSystem.__index = JumpResetSystem
JumpResetSystem.prototype = {}
JumpResetSystem.prototype.__index = JumpResetSystem.prototype
JumpResetSystem.prototype.constructor = JumpResetSystem
JumpResetSystem.____super = System
setmetatable(JumpResetSystem, JumpResetSystem.____super)
setmetatable(JumpResetSystem.prototype, JumpResetSystem.____super.prototype)
function JumpResetSystem.new(...)
    local self = setmetatable({}, JumpResetSystem.prototype)
    self:____constructor(...)
    return self
end
function JumpResetSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.JumpResetSystem._id
    self._flag = ____exports.JumpResetSystem._flag
    self._aspect = ____exports.JumpResetSystem._aspect
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {
            hasComponent(nil, Player),
            isNotBodyType(nil, "dynamic"),
        })
        if not result then
            return
        end
        local player = unpack(result)
        local nx, ny = contact:getNormal()
        if nx == -1 or nx == 1 or ny < 0 then
            local movement = player:as(Movement)
            if movement then
                movement.jumpCount = 0
            end
        end
    end
end
JumpResetSystem._id = "JumpReset"
JumpResetSystem._flag = SystemFlag.JumpReset
JumpResetSystem._aspect = NeverAspect.new()
return ____exports
