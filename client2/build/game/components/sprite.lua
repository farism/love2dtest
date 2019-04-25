--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Sprite = exports.Sprite or {};
exports.Sprite.__index = exports.Sprite;
exports.Sprite.prototype = exports.Sprite.prototype or {};
exports.Sprite.prototype.__index = exports.Sprite.prototype;
exports.Sprite.prototype.constructor = exports.Sprite;
exports.Sprite.new = function(...)
    local self = setmetatable({}, exports.Sprite.prototype);
    self:____constructor(...);
    return self;
end;
exports.Sprite.prototype.____constructor = function(self, filepath, x, y, width, height)
    self._id = exports.Sprite._id;
    self._flag = Flag.Sprite;
    if filepath == nil then
        filepath = "";
    end
    if x == nil then
        x = 0;
    end
    if y == nil then
        y = 0;
    end
    if width == nil then
        width = 0;
    end
    if height == nil then
        height = 0;
    end
    self.filepath = filepath;
    self.x = x;
    self.y = y;
    self.width = width;
    self.height = height;
end;
exports.Sprite._id = "Sprite";
exports.Sprite._flag = Flag.Sprite;
return exports;
