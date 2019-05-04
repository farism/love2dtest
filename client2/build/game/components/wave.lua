--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.WaveType = {}
____exports.WaveType.Circular = "circular"
____exports.WaveType.circular = "Circular"
____exports.WaveType.Horizontal = "horizontal"
____exports.WaveType.horizontal = "Horizontal"
____exports.WaveType.Vertical = "vertical"
____exports.WaveType.vertical = "Vertical"
____exports.Wave = {}
local Wave = ____exports.Wave
Wave.name = "Wave"
Wave.__index = Wave
Wave.prototype = {}
Wave.prototype.__index = Wave.prototype
Wave.prototype.constructor = Wave
function Wave.new(...)
    local self = setmetatable({}, Wave.prototype)
    self:____constructor(...)
    return self
end
function Wave.prototype.____constructor(self, type, x, y, amplitude, frequency, direction)
    self._id = ____exports.Wave._id
    self._flag = ComponentFlag.Wave
    if type == nil then
        type = ____exports.WaveType.Vertical
    end
    if x == nil then
        x = 0
    end
    if y == nil then
        y = 0
    end
    if amplitude == nil then
        amplitude = 0
    end
    if frequency == nil then
        frequency = 0
    end
    if direction == nil then
        direction = 0
    end
    self.type = type
    self.x = x
    self.y = y
    self.amplitude = amplitude
    self.frequency = frequency
    self.direction = direction
end
Wave._id = "Wave"
Wave._flag = ComponentFlag.Wave
____exports.CircularWave = {}
local CircularWave = ____exports.CircularWave
CircularWave.name = "CircularWave"
CircularWave.__index = CircularWave
CircularWave.prototype = {}
CircularWave.prototype.__index = CircularWave.prototype
CircularWave.prototype.constructor = CircularWave
CircularWave.____super = Wave
setmetatable(CircularWave, CircularWave.____super)
setmetatable(CircularWave.prototype, CircularWave.____super.prototype)
function CircularWave.new(...)
    local self = setmetatable({}, CircularWave.prototype)
    self:____constructor(...)
    return self
end
function CircularWave.prototype.____constructor(self, x, y, amplitude, frequency)
    if x == nil then
        x = 0
    end
    if y == nil then
        y = 0
    end
    if amplitude == nil then
        amplitude = 0
    end
    if frequency == nil then
        frequency = 0
    end
    Wave.prototype.____constructor(self, ____exports.WaveType.Circular, x, y, amplitude, frequency)
end
____exports.HorizontalWave = {}
local HorizontalWave = ____exports.HorizontalWave
HorizontalWave.name = "HorizontalWave"
HorizontalWave.__index = HorizontalWave
HorizontalWave.prototype = {}
HorizontalWave.prototype.__index = HorizontalWave.prototype
HorizontalWave.prototype.constructor = HorizontalWave
HorizontalWave.____super = Wave
setmetatable(HorizontalWave, HorizontalWave.____super)
setmetatable(HorizontalWave.prototype, HorizontalWave.____super.prototype)
function HorizontalWave.new(...)
    local self = setmetatable({}, HorizontalWave.prototype)
    self:____constructor(...)
    return self
end
function HorizontalWave.prototype.____constructor(self, x, y, amplitude, frequency, direction)
    if x == nil then
        x = 0
    end
    if y == nil then
        y = 0
    end
    if amplitude == nil then
        amplitude = 0
    end
    if frequency == nil then
        frequency = 0
    end
    if direction == nil then
        direction = 1
    end
    Wave.prototype.____constructor(self, ____exports.WaveType.Horizontal, x, y, amplitude, frequency, direction)
end
____exports.VerticalWave = {}
local VerticalWave = ____exports.VerticalWave
VerticalWave.name = "VerticalWave"
VerticalWave.__index = VerticalWave
VerticalWave.prototype = {}
VerticalWave.prototype.__index = VerticalWave.prototype
VerticalWave.prototype.constructor = VerticalWave
VerticalWave.____super = Wave
setmetatable(VerticalWave, VerticalWave.____super)
setmetatable(VerticalWave.prototype, VerticalWave.____super.prototype)
function VerticalWave.new(...)
    local self = setmetatable({}, VerticalWave.prototype)
    self:____constructor(...)
    return self
end
function VerticalWave.prototype.____constructor(self, x, y, amplitude, frequency, direction)
    if x == nil then
        x = 0
    end
    if y == nil then
        y = 0
    end
    if amplitude == nil then
        amplitude = 0
    end
    if frequency == nil then
        frequency = 0
    end
    if direction == nil then
        direction = 1
    end
    Wave.prototype.____constructor(self, ____exports.WaveType.Vertical, x, y, amplitude, frequency, direction)
end
return ____exports
