--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Sprite = require("game.components.Sprite");
local Sprite = __TSTL_Sprite.Sprite;
local __TSTL_Animation = require("game.components.Animation");
local Animation = __TSTL_Animation.Animation;
exports.AnimateSpriteSystem = exports.AnimateSpriteSystem or {};
exports.AnimateSpriteSystem.__index = exports.AnimateSpriteSystem;
exports.AnimateSpriteSystem.prototype = exports.AnimateSpriteSystem.prototype or {};
exports.AnimateSpriteSystem.prototype.__index = exports.AnimateSpriteSystem.prototype;
exports.AnimateSpriteSystem.prototype.constructor = exports.AnimateSpriteSystem;
exports.AnimateSpriteSystem.____super = System;
setmetatable(exports.AnimateSpriteSystem, exports.AnimateSpriteSystem.____super);
setmetatable(exports.AnimateSpriteSystem.prototype, exports.AnimateSpriteSystem.____super.prototype);
exports.AnimateSpriteSystem.new = function(...)
    local self = setmetatable({}, exports.AnimateSpriteSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.AnimateSpriteSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.AnimateSpriteSystem._id;
    self._flag = exports.AnimateSpriteSystem._flag;
    self._aspect = exports.AnimateSpriteSystem._aspect;
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local animation = entity:as(Animation);
            local sprite = entity:as(Sprite);
            if (not animation) or (not sprite) then
                return;
            end
            local elapsedTime = animation.elapsedTime + dt;
            local sequence = animation.sequences[animation.currentSequence + 1];
            if elapsedTime > sequence.step then
                animation.elapsedTime = elapsedTime - sequence.step;
                animation.currentFrame = ((animation.currentFrame == sequence.length) and ((function(o, i, v)
                    o[i] = v;
                    return v;
                end)(animation, "currentFrame", 1))) or ((function(o, i, v)
                    o[i] = v;
                    return v;
                end)(animation, "currentFrame", animation.currentFrame + 1));
            else
                animation.elapsedTime = elapsedTime;
            end
        end);
    end;
end;
exports.AnimateSpriteSystem._id = "AnimateSprite";
exports.AnimateSpriteSystem._flag = SystemFlag.AnimateSprite;
exports.AnimateSpriteSystem._aspect = Aspect.new({Animation, Sprite});
return exports;
