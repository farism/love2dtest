--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
local __TSTL_asset = require("game.utils.asset")
local loadImage = __TSTL_asset.loadImage
____exports.Sprite = {}
local Sprite = ____exports.Sprite
Sprite.name = "Sprite"
Sprite.__index = Sprite
Sprite.prototype = {}
Sprite.prototype.__index = Sprite.prototype
Sprite.prototype.constructor = Sprite
function Sprite.new(...)
    local self = setmetatable({}, Sprite.prototype)
    self:____constructor(...)
    return self
end
function Sprite.prototype.____constructor(self, filepath, x, y, width, height)
    self._id = ____exports.Sprite._id
    self._flag = ComponentFlag.Sprite
    if filepath == nil then
        filepath = ""
    end
    if x == nil then
        x = 0
    end
    if y == nil then
        y = 0
    end
    if width == nil then
        width = 32
    end
    if height == nil then
        height = 32
    end
    self.filepath = filepath
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.image = loadImage(nil, filepath)
    local sw, sh = unpack(self.image and ({self.image:getDimensions()}) or {
        32,
        32,
    })
    self.frame = love.graphics.newQuad(x, y, width, height, sw, sh)
end
Sprite._id = "Sprite"
Sprite._flag = ComponentFlag.Sprite
return ____exports
