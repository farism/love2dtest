--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.WaveType = {};
exports.WaveType.Circular = "circular";
exports.WaveType.circular = "Circular";
exports.WaveType.Horizontal = "horizontal";
exports.WaveType.horizontal = "Horizontal";
exports.WaveType.Vertical = "vertical";
exports.WaveType.vertical = "Vertical";
exports.Wave = exports.Wave or {};
exports.Wave.__index = exports.Wave;
exports.Wave.prototype = exports.Wave.prototype or {};
exports.Wave.prototype.__index = exports.Wave.prototype;
exports.Wave.prototype.constructor = exports.Wave;
exports.Wave.new = function(...)
    local self = setmetatable({}, exports.Wave.prototype);
    self:____constructor(...);
    return self;
end;
exports.Wave.prototype.____constructor = function(self, type, x, y, amplitude, frequency, direction)
    self._id = exports.Wave._id;
    self._flag = ComponentFlag.Wave;
    if type == nil then
        type = exports.WaveType.Vertical;
    end
    if x == nil then
        x = 0;
    end
    if y == nil then
        y = 0;
    end
    if amplitude == nil then
        amplitude = 0;
    end
    if frequency == nil then
        frequency = 0;
    end
    if direction == nil then
        direction = 0;
    end
    self.type = type;
    self.x = x;
    self.y = y;
    self.amplitude = amplitude;
    self.frequency = frequency;
    self.direction = direction;
end;
exports.Wave._id = "Wave";
exports.Wave._flag = ComponentFlag.Wave;
exports.CircularWave = exports.CircularWave or {};
exports.CircularWave.__index = exports.CircularWave;
exports.CircularWave.prototype = exports.CircularWave.prototype or {};
exports.CircularWave.prototype.__index = exports.CircularWave.prototype;
exports.CircularWave.prototype.constructor = exports.CircularWave;
exports.CircularWave.____super = exports.Wave;
setmetatable(exports.CircularWave, exports.CircularWave.____super);
setmetatable(exports.CircularWave.prototype, exports.CircularWave.____super.prototype);
exports.CircularWave.new = function(...)
    local self = setmetatable({}, exports.CircularWave.prototype);
    self:____constructor(...);
    return self;
end;
exports.CircularWave.prototype.____constructor = function(self, x, y, amplitude, frequency)
    if x == nil then
        x = 0;
    end
    if y == nil then
        y = 0;
    end
    if amplitude == nil then
        amplitude = 0;
    end
    if frequency == nil then
        frequency = 0;
    end
    exports.Wave.prototype.____constructor(self, exports.WaveType.Circular, x, y, amplitude, frequency);
end;
exports.HorizontalWave = exports.HorizontalWave or {};
exports.HorizontalWave.__index = exports.HorizontalWave;
exports.HorizontalWave.prototype = exports.HorizontalWave.prototype or {};
exports.HorizontalWave.prototype.__index = exports.HorizontalWave.prototype;
exports.HorizontalWave.prototype.constructor = exports.HorizontalWave;
exports.HorizontalWave.____super = exports.Wave;
setmetatable(exports.HorizontalWave, exports.HorizontalWave.____super);
setmetatable(exports.HorizontalWave.prototype, exports.HorizontalWave.____super.prototype);
exports.HorizontalWave.new = function(...)
    local self = setmetatable({}, exports.HorizontalWave.prototype);
    self:____constructor(...);
    return self;
end;
exports.HorizontalWave.prototype.____constructor = function(self, x, y, amplitude, frequency, direction)
    if x == nil then
        x = 0;
    end
    if y == nil then
        y = 0;
    end
    if amplitude == nil then
        amplitude = 0;
    end
    if frequency == nil then
        frequency = 0;
    end
    if direction == nil then
        direction = 1;
    end
    exports.Wave.prototype.____constructor(self, exports.WaveType.Horizontal, x, y, amplitude, frequency, direction);
end;
exports.VerticalWave = exports.VerticalWave or {};
exports.VerticalWave.__index = exports.VerticalWave;
exports.VerticalWave.prototype = exports.VerticalWave.prototype or {};
exports.VerticalWave.prototype.__index = exports.VerticalWave.prototype;
exports.VerticalWave.prototype.constructor = exports.VerticalWave;
exports.VerticalWave.____super = exports.Wave;
setmetatable(exports.VerticalWave, exports.VerticalWave.____super);
setmetatable(exports.VerticalWave.prototype, exports.VerticalWave.____super.prototype);
exports.VerticalWave.new = function(...)
    local self = setmetatable({}, exports.VerticalWave.prototype);
    self:____constructor(...);
    return self;
end;
exports.VerticalWave.prototype.____constructor = function(self, x, y, amplitude, frequency, direction)
    if x == nil then
        x = 0;
    end
    if y == nil then
        y = 0;
    end
    if amplitude == nil then
        amplitude = 0;
    end
    if frequency == nil then
        frequency = 0;
    end
    if direction == nil then
        direction = 1;
    end
    exports.Wave.prototype.____constructor(self, exports.WaveType.Vertical, x, y, amplitude, frequency, direction);
end;
return exports;
