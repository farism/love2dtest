--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Platform = {}
local Platform = ____exports.Platform
Platform.name = "Platform"
Platform.__index = Platform
Platform.prototype = {}
Platform.prototype.__index = Platform.prototype
Platform.prototype.constructor = Platform
function Platform.new(...)
    local self = setmetatable({}, Platform.prototype)
    self:____constructor(...)
    return self
end
function Platform.prototype.____constructor(self, fall, initialX, initialY)
    self._id = ____exports.Platform._id
    self._flag = ComponentFlag.Platform
    if fall == nil then
        fall = 0
    end
    if initialX == nil then
        initialX = 0
    end
    if initialY == nil then
        initialY = 0
    end
    self.fall = fall
    self.initialX = initialX
    self.initialY = initialY
end
Platform._id = "Platform"
Platform._flag = ComponentFlag.Platform
return ____exports
