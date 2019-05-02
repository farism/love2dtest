--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Position = require("game.components.Position");
local Position = __TSTL_Position.Position;
local __TSTL_Sprite = require("game.components.Sprite");
local Sprite = __TSTL_Sprite.Sprite;
exports.SpriteRenderSystem = exports.SpriteRenderSystem or {};
exports.SpriteRenderSystem.__index = exports.SpriteRenderSystem;
exports.SpriteRenderSystem.prototype = exports.SpriteRenderSystem.prototype or {};
exports.SpriteRenderSystem.prototype.__index = exports.SpriteRenderSystem.prototype;
exports.SpriteRenderSystem.prototype.constructor = exports.SpriteRenderSystem;
exports.SpriteRenderSystem.____super = System;
setmetatable(exports.SpriteRenderSystem, exports.SpriteRenderSystem.____super);
setmetatable(exports.SpriteRenderSystem.prototype, exports.SpriteRenderSystem.____super.prototype);
exports.SpriteRenderSystem.new = function(...)
    local self = setmetatable({}, exports.SpriteRenderSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.SpriteRenderSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.SpriteRenderSystem._id;
    self._flag = exports.SpriteRenderSystem._flag;
    self._aspect = exports.SpriteRenderSystem._aspect;
    self.draw = function(____)
        self.entities:forEach(function(____, entity)
            local position = entity:as(Position);
            local sprite = entity:as(Sprite);
            if (position and sprite) and sprite.image then
                love.graphics.draw(sprite.image, sprite.frame, math.floor(position.x + 0.5), math.floor(position.y + 0.5));
            end
        end);
    end;
end;
exports.SpriteRenderSystem._id = "SpriteRenderSystem";
exports.SpriteRenderSystem._flag = SystemFlag.SpriteRender;
exports.SpriteRenderSystem._aspect = Aspect.new({Position, Sprite});
return exports;
