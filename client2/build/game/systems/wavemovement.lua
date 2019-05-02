--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local __TSTL_Aspect = require("ecs.Aspect");
local Aspect = __TSTL_Aspect.Aspect;
local __TSTL_GameObject = require("game.components.GameObject");
local GameObject = __TSTL_GameObject.GameObject;
local __TSTL_Wave = require("game.components.Wave");
local Wave = __TSTL_Wave.Wave;
local WaveType = __TSTL_Wave.WaveType;
exports.WaveMovementSystem = exports.WaveMovementSystem or {};
exports.WaveMovementSystem.__index = exports.WaveMovementSystem;
exports.WaveMovementSystem.prototype = exports.WaveMovementSystem.prototype or {};
exports.WaveMovementSystem.prototype.__index = exports.WaveMovementSystem.prototype;
exports.WaveMovementSystem.prototype.constructor = exports.WaveMovementSystem;
exports.WaveMovementSystem.____super = System;
setmetatable(exports.WaveMovementSystem, exports.WaveMovementSystem.____super);
setmetatable(exports.WaveMovementSystem.prototype, exports.WaveMovementSystem.____super.prototype);
exports.WaveMovementSystem.new = function(...)
    local self = setmetatable({}, exports.WaveMovementSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.WaveMovementSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.WaveMovementSystem._id;
    self._flag = exports.WaveMovementSystem._flag;
    self._aspect = exports.WaveMovementSystem._aspect;
    self.time = 0;
    self.update = function(____, dt)
        self.time = self.time + dt;
        self.entities:forEach(function(____, entity)
            local wave = entity:as(Wave);
            local gameObject = entity:as(GameObject);
            if (not wave) or (not gameObject) then
                return;
            end
            local step = self.time * wave.frequency;
            local body = gameObject.fixture:getBody();
            if wave.type == WaveType.Circular then
                body:setPosition(wave.x + (math.cos(step) * wave.amplitude), wave.y + (math.sin(step) * wave.amplitude));
            elseif wave.type == WaveType.Horizontal then
                body:setX(wave.x + (math.cos(step) * wave.amplitude));
            elseif wave.type == WaveType.Vertical then
                body:setY(wave.y + (math.sin(step) * wave.amplitude));
            end
        end);
    end;
end;
exports.WaveMovementSystem._id = "WaveMovement";
exports.WaveMovementSystem._flag = SystemFlag.WaveMovement;
exports.WaveMovementSystem._aspect = Aspect.new({GameObject, Wave});
return exports;
