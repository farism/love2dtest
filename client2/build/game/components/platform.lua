--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Platform = exports.Platform or {};
exports.Platform.__index = exports.Platform;
exports.Platform.prototype = exports.Platform.prototype or {};
exports.Platform.prototype.__index = exports.Platform.prototype;
exports.Platform.prototype.constructor = exports.Platform;
exports.Platform.new = function(...)
    local self = setmetatable({}, exports.Platform.prototype);
    self:____constructor(...);
    return self;
end;
exports.Platform.prototype.____constructor = function(self, fall, initialX, initialY)
    self._id = exports.Platform._id;
    self._flag = Flag.Platform;
    if fall == nil then
        fall = 0;
    end
    if initialX == nil then
        initialX = 0;
    end
    if initialY == nil then
        initialY = 0;
    end
    self.fall = fall;
    self.initialX = initialX;
    self.initialY = initialY;
end;
exports.Platform._id = "Platform";
exports.Platform._flag = Flag.Platform;
return exports;
