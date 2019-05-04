--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Damage = {}
local Damage = ____exports.Damage
Damage.name = "Damage"
Damage.__index = Damage
Damage.prototype = {}
Damage.prototype.__index = Damage.prototype
Damage.prototype.constructor = Damage
function Damage.new(...)
    local self = setmetatable({}, Damage.prototype)
    self:____constructor(...)
    return self
end
function Damage.prototype.____constructor(self, hitpoints)
    self._id = ____exports.Damage._id
    self._flag = ComponentFlag.Damage
    if hitpoints == nil then
        hitpoints = 0
    end
    self.hitpoints = hitpoints
end
Damage._id = "Damage"
Damage._flag = ComponentFlag.Damage
return ____exports
