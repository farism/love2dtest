--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
function __TS__ArrayMap(arr, callbackfn)
    local newArray = {}
    do
        local i = 0
        while i < #arr do
            newArray[i + 1] = callbackfn(_G, arr[i + 1], i, arr)
            i = i + 1
        end
    end
    return newArray
end

local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
local Sequence = {}
Sequence.name = "Sequence"
Sequence.__index = Sequence
Sequence.prototype = {}
Sequence.prototype.__index = Sequence.prototype
Sequence.prototype.constructor = Sequence
function Sequence.new(...)
    local self = setmetatable({}, Sequence.prototype)
    self:____constructor(...)
    return self
end
function Sequence.prototype.____constructor(self, x, y, width, height, spriteWidth, spriteHeight, length, duration)
    if x == nil then
        x = 0
    end
    if y == nil then
        y = 0
    end
    if width == nil then
        width = 0
    end
    if height == nil then
        height = 0
    end
    if spriteWidth == nil then
        spriteWidth = 0
    end
    if spriteHeight == nil then
        spriteHeight = 0
    end
    if length == nil then
        length = 0
    end
    if duration == nil then
        duration = 0
    end
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.length = length
    self.duration = duration
    self.step = duration / length
    self.frames = __TS__ArrayMap(Array:from(Array(nil, length)), function() return love.graphics.newQuad(x + (self.step - 1) * width, y, width, duration, spriteWidth, spriteHeight) end)
end
____exports.Animation = {}
local Animation = ____exports.Animation
Animation.name = "Animation"
Animation.__index = Animation
Animation.prototype = {}
Animation.prototype.__index = Animation.prototype
Animation.prototype.constructor = Animation
function Animation.new(...)
    local self = setmetatable({}, Animation.prototype)
    self:____constructor(...)
    return self
end
function Animation.prototype.____constructor(self, sequences, currentSequence)
    self._id = ____exports.Animation._id
    self._flag = ComponentFlag.Animation
    if sequences == nil then
        sequences = {}
    end
    if currentSequence == nil then
        currentSequence = 0
    end
    self.elapsedTime = 0
    self.currentFrame = 1
    self.currentSequence = currentSequence
    self.sequences = sequences
end
Animation._id = "Animation"
Animation._flag = ComponentFlag.Animation
return ____exports
