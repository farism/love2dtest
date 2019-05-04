--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
____exports.IntervalSystem = {}
local IntervalSystem = ____exports.IntervalSystem
IntervalSystem.name = "IntervalSystem"
IntervalSystem.__index = IntervalSystem
IntervalSystem.prototype = {}
IntervalSystem.prototype.__index = IntervalSystem.prototype
IntervalSystem.prototype.constructor = IntervalSystem
IntervalSystem.____super = System
setmetatable(IntervalSystem, IntervalSystem.____super)
setmetatable(IntervalSystem.prototype, IntervalSystem.____super.prototype)
function IntervalSystem.new(...)
    local self = setmetatable({}, IntervalSystem.prototype)
    self:____constructor(...)
    return self
end
function IntervalSystem.prototype.____constructor(self, interval, onUpdate)
    System.prototype.____constructor(self)
    self._id = ____exports.IntervalSystem._id
    self._aspect = ____exports.IntervalSystem._aspect
    self.update = function(____, dt)
        local elapsed = self.elapsed + dt
        if elapsed >= self.interval then
            self.elapsed = elapsed - self.interval
            self:onUpdate(self.entities)
        else
            self.elapsed = elapsed
        end
    end
    self.interval = interval
    self.elapsed = 0
    self.onUpdate = onUpdate
end
IntervalSystem._id = "IntervalSystem"
IntervalSystem._aspect = Aspect.new()
return ____exports
