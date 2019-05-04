--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Upgrades = {}
local Upgrades = ____exports.Upgrades
Upgrades.name = "Upgrades"
Upgrades.__index = Upgrades
Upgrades.prototype = {}
Upgrades.prototype.__index = Upgrades.prototype
Upgrades.prototype.constructor = Upgrades
function Upgrades.new(...)
    local self = setmetatable({}, Upgrades.prototype)
    self:____constructor(...)
    return self
end
function Upgrades.prototype.____constructor(self, passive, throw_, dash, grapple, dig)
    self._id = ____exports.Upgrades._id
    self._flag = ComponentFlag.Upgrades
    self.passive = passive
    self.throw = throw_
    self.dash = dash
    self.grapple = grapple
    self.dig = dig
end
Upgrades._id = "Upgrades"
Upgrades._flag = ComponentFlag.Upgrades
return ____exports
