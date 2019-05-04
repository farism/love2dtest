--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_Container = require("game.components.Container")
local Container = __TSTL_Container.Container
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
____exports.ContainerSystem = {}
local ContainerSystem = ____exports.ContainerSystem
ContainerSystem.name = "ContainerSystem"
ContainerSystem.__index = ContainerSystem
ContainerSystem.prototype = {}
ContainerSystem.prototype.__index = ContainerSystem.prototype
ContainerSystem.prototype.constructor = ContainerSystem
ContainerSystem.____super = System
setmetatable(ContainerSystem, ContainerSystem.____super)
setmetatable(ContainerSystem.prototype, ContainerSystem.____super.prototype)
function ContainerSystem.new(...)
    local self = setmetatable({}, ContainerSystem.prototype)
    self:____constructor(...)
    return self
end
function ContainerSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.ContainerSystem._id
    self._flag = ____exports.ContainerSystem._flag
    self._aspect = ____exports.ContainerSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
        end)
    end
end
ContainerSystem._id = "Container"
ContainerSystem._flag = SystemFlag.Container
ContainerSystem._aspect = Aspect.new({Container})
return ____exports
