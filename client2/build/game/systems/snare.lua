--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aspect = require("ecs.Aspect")
local NeverAspect = __TSTL_Aspect.NeverAspect
local __TSTL_collision = require("game.utils.collision")
local check = __TSTL_collision.check
local hasComponent = __TSTL_collision.hasComponent
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
local __TSTL_Snare = require("game.components.Snare")
local Snare = __TSTL_Snare.Snare
____exports.SnareSystem = {}
local SnareSystem = ____exports.SnareSystem
SnareSystem.name = "SnareSystem"
SnareSystem.__index = SnareSystem
SnareSystem.prototype = {}
SnareSystem.prototype.__index = SnareSystem.prototype
SnareSystem.prototype.constructor = SnareSystem
SnareSystem.____super = System
setmetatable(SnareSystem, SnareSystem.____super)
setmetatable(SnareSystem.prototype, SnareSystem.____super.prototype)
function SnareSystem.new(...)
    local self = setmetatable({}, SnareSystem.prototype)
    self:____constructor(...)
    return self
end
function SnareSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.SnareSystem._id
    self._flag = ____exports.SnareSystem._flag
    self._aspect = ____exports.SnareSystem._aspect
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {
            hasComponent(nil, Player),
            hasComponent(nil, Snare),
        })
        if not result then
            return
        end
    end
end
SnareSystem._id = "Snare"
SnareSystem._flag = SystemFlag.Snare
SnareSystem._aspect = NeverAspect.new()
return ____exports
