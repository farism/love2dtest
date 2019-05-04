--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local __TSTL_Sprite = require("game.components.Sprite")
local Sprite = __TSTL_Sprite.Sprite
____exports.SpriteRenderSystem = {}
local SpriteRenderSystem = ____exports.SpriteRenderSystem
SpriteRenderSystem.name = "SpriteRenderSystem"
SpriteRenderSystem.__index = SpriteRenderSystem
SpriteRenderSystem.prototype = {}
SpriteRenderSystem.prototype.__index = SpriteRenderSystem.prototype
SpriteRenderSystem.prototype.constructor = SpriteRenderSystem
SpriteRenderSystem.____super = System
setmetatable(SpriteRenderSystem, SpriteRenderSystem.____super)
setmetatable(SpriteRenderSystem.prototype, SpriteRenderSystem.____super.prototype)
function SpriteRenderSystem.new(...)
    local self = setmetatable({}, SpriteRenderSystem.prototype)
    self:____constructor(...)
    return self
end
function SpriteRenderSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.SpriteRenderSystem._id
    self._flag = ____exports.SpriteRenderSystem._flag
    self._aspect = ____exports.SpriteRenderSystem._aspect
    self.draw = function()
        self.entities:forEach(function(____, entity)
            local position = entity:as(Position)
            local sprite = entity:as(Sprite)
            if position and sprite and sprite.image then
                love.graphics.draw(sprite.image, sprite.frame, math.floor(position.x + 0.5), math.floor(position.y + 0.5))
            end
        end)
    end
end
SpriteRenderSystem._id = "SpriteRenderSystem"
SpriteRenderSystem._flag = SystemFlag.SpriteRender
SpriteRenderSystem._aspect = Aspect.new({
    Position,
    Sprite,
})
return ____exports
