--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Snare = {}
local Snare = ____exports.Snare
Snare.name = "Snare"
Snare.__index = Snare
Snare.prototype = {}
Snare.prototype.__index = Snare.prototype
Snare.prototype.constructor = Snare
function Snare.new(...)
    local self = setmetatable({}, Snare.prototype)
    self:____constructor(...)
    return self
end
function Snare.prototype.____constructor(self, strength)
    self._id = ____exports.Snare._id
    self._flag = ComponentFlag.Snare
    if strength == nil then
        strength = 0
    end
    self.strength = strength
end
Snare._id = "Snare"
Snare._flag = ComponentFlag.Snare
return ____exports
