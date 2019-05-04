--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Health = {}
local Health = ____exports.Health
Health.name = "Health"
Health.__index = Health
Health.prototype = {}
Health.prototype.__index = Health.prototype
Health.prototype.constructor = Health
function Health.new(...)
    local self = setmetatable({}, Health.prototype)
    self:____constructor(...)
    return self
end
function Health.prototype.____constructor(self, hitpoints, armor)
    self._id = ____exports.Health._id
    self._flag = ComponentFlag.Health
    if hitpoints == nil then
        hitpoints = 1
    end
    if armor == nil then
        armor = 0
    end
    self.hitpoints = hitpoints
    self.armor = armor
end
Health._id = "Health"
Health._flag = ComponentFlag.Health
return ____exports
