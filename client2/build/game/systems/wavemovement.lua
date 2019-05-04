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
local __TSTL_Wave = require("game.components.Wave")
local Wave = __TSTL_Wave.Wave
local WaveType = __TSTL_Wave.WaveType
____exports.WaveMovementSystem = {}
local WaveMovementSystem = ____exports.WaveMovementSystem
WaveMovementSystem.name = "WaveMovementSystem"
WaveMovementSystem.__index = WaveMovementSystem
WaveMovementSystem.prototype = {}
WaveMovementSystem.prototype.__index = WaveMovementSystem.prototype
WaveMovementSystem.prototype.constructor = WaveMovementSystem
WaveMovementSystem.____super = System
setmetatable(WaveMovementSystem, WaveMovementSystem.____super)
setmetatable(WaveMovementSystem.prototype, WaveMovementSystem.____super.prototype)
function WaveMovementSystem.new(...)
    local self = setmetatable({}, WaveMovementSystem.prototype)
    self:____constructor(...)
    return self
end
function WaveMovementSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.WaveMovementSystem._id
    self._flag = ____exports.WaveMovementSystem._flag
    self._aspect = ____exports.WaveMovementSystem._aspect
    self.time = 0
    self.update = function(____, dt)
        self.time = self.time + dt
        self.entities:forEach(function(____, entity)
            local wave = entity:as(Wave)
            local gameObject = entity:as(GameObject)
            if not wave or not gameObject then
                return
            end
            local step = self.time * wave.frequency
            local body = gameObject.fixture:getBody()
            if wave.type == WaveType.Circular then
                body:setPosition(wave.x + math.cos(step) * wave.amplitude, wave.y + math.sin(step) * wave.amplitude)
            elseif wave.type == WaveType.Horizontal then
                body:setX(wave.x + math.cos(step) * wave.amplitude)
            elseif wave.type == WaveType.Vertical then
                body:setY(wave.y + math.sin(step) * wave.amplitude)
            end
        end)
    end
end
WaveMovementSystem._id = "WaveMovement"
WaveMovementSystem._flag = SystemFlag.WaveMovement
WaveMovementSystem._aspect = Aspect.new({
    GameObject,
    Wave,
})
return ____exports
