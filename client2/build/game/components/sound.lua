--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Sound = {}
local Sound = ____exports.Sound
Sound.name = "Sound"
Sound.__index = Sound
Sound.prototype = {}
Sound.prototype.__index = Sound.prototype
Sound.prototype.constructor = Sound
function Sound.new(...)
    local self = setmetatable({}, Sound.prototype)
    self:____constructor(...)
    return self
end
function Sound.prototype.____constructor(self, filepath, sound)
    self._id = ____exports.Sound._id
    self._flag = ComponentFlag.Sound
    if filepath == nil then
        filepath = ""
    end
    self.filepath = filepath
    self.sound = sound
end
Sound._id = "Sound"
Sound._flag = ComponentFlag.Sound
return ____exports
