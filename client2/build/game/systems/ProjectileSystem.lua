--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_collision = require("game.utils.collision")
local check = __TSTL_collision.check
local hasComponent = __TSTL_collision.hasComponent
local isSensor = __TSTL_collision.isSensor
local __TSTL_Projectile = require("game.components.Projectile")
local Projectile = __TSTL_Projectile.Projectile
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
____exports.ProjectileSystem = {}
local ProjectileSystem = ____exports.ProjectileSystem
ProjectileSystem.name = "ProjectileSystem"
ProjectileSystem.__index = ProjectileSystem
ProjectileSystem.prototype = {}
ProjectileSystem.prototype.__index = ProjectileSystem.prototype
ProjectileSystem.prototype.constructor = ProjectileSystem
ProjectileSystem.____super = System
setmetatable(ProjectileSystem, ProjectileSystem.____super)
setmetatable(ProjectileSystem.prototype, ProjectileSystem.____super.prototype)
function ProjectileSystem.new(...)
    local self = setmetatable({}, ProjectileSystem.prototype)
    self:____constructor(...)
    return self
end
function ProjectileSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.ProjectileSystem._id
    self._flag = ____exports.ProjectileSystem._flag
    self._aspect = ____exports.ProjectileSystem._aspect
    self.beginContact = function(____, a, b, c)
        local result = check(nil, a, b, {
            hasComponent(nil, Projectile),
            isSensor,
        })
        if result then
            result[0 + 1]:destroy()
        end
    end
end
ProjectileSystem._id = "ProjectileSystem"
ProjectileSystem._flag = SystemFlag.ProjectileSystem
ProjectileSystem._aspect = Aspect.new({Projectile})
return ____exports
