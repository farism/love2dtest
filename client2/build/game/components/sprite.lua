--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
local __TSTL_asset = require("game.utils.asset");
local loadImage = __TSTL_asset.loadImage;
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
    self._flag = ComponentFlag.Sprite;
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
        width = 32;
    end
    if height == nil then
        height = 32;
    end
    self.filepath = filepath;
    self.x = x;
    self.y = y;
    self.width = width;
    self.height = height;
    self.image = loadImage(nil, filepath);
    local sw, sh = unpack((self.image and ({self.image:getDimensions()})) or {32, 32});
    self.frame = love.graphics.newQuad(x, y, width, height, sw, sh);
end;
exports.Sprite._id = "Sprite";
exports.Sprite._flag = ComponentFlag.Sprite;
return exports;
