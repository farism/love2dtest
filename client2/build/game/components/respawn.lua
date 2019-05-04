--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Respawn = {}
local Respawn = ____exports.Respawn
Respawn.name = "Respawn"
Respawn.__index = Respawn
Respawn.prototype = {}
Respawn.prototype.__index = Respawn.prototype
Respawn.prototype.constructor = Respawn
function Respawn.new(...)
    local self = setmetatable({}, Respawn.prototype)
    self:____constructor(...)
    return self
end
function Respawn.prototype.____constructor(self, duration)
    self._id = ____exports.Respawn._id
    self._flag = ComponentFlag.Respawn
    self.timer = 0
    if duration == nil then
        duration = 0
    end
    self.duration = duration
end
Respawn._id = "Respawn"
Respawn._flag = ComponentFlag.Respawn
return ____exports
