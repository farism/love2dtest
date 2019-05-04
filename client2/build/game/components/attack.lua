--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Attack = {}
local Attack = ____exports.Attack
Attack.name = "Attack"
Attack.__index = Attack
Attack.prototype = {}
Attack.prototype.__index = Attack.prototype
Attack.prototype.constructor = Attack
function Attack.new(...)
    local self = setmetatable({}, Attack.prototype)
    self:____constructor(...)
    return self
end
function Attack.prototype.____constructor(self, target)
    self._id = ____exports.Attack._id
    self._flag = ComponentFlag.Attack
    self.target = target
end
Attack._id = "Attack"
Attack._flag = ComponentFlag.Attack
return ____exports
