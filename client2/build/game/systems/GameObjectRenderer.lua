--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_GameObject = require("game.components.GameObject");
local GameObject = __TSTL_GameObject.GameObject;
local __TSTL_flags = require("game.flags");
local SystemFlag = __TSTL_flags.SystemFlag;
local isShapeType;
isShapeType = function(____, type, shape)
    return shape:getType() == type;
end;
exports.GameObjectRenderer = exports.GameObjectRenderer or {};
exports.GameObjectRenderer.__index = exports.GameObjectRenderer;
exports.GameObjectRenderer.prototype = exports.GameObjectRenderer.prototype or {};
exports.GameObjectRenderer.prototype.__index = exports.GameObjectRenderer.prototype;
exports.GameObjectRenderer.prototype.constructor = exports.GameObjectRenderer;
exports.GameObjectRenderer.____super = System;
setmetatable(exports.GameObjectRenderer, exports.GameObjectRenderer.____super);
setmetatable(exports.GameObjectRenderer.prototype, exports.GameObjectRenderer.____super.prototype);
exports.GameObjectRenderer.new = function(...)
    local self = setmetatable({}, exports.GameObjectRenderer.prototype);
    self:____constructor(...);
    return self;
end;
exports.GameObjectRenderer.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.GameObjectRenderer._id;
    self._flag = exports.GameObjectRenderer._flag;
    self.draw = function(____)
        self.entities:forEach(function(____, entity)
            local gameObject = entity:as(GameObject);
            if not gameObject then
                return;
            end
            local body = gameObject.fixture:getBody();
            local shape = gameObject.fixture:getShape();
            if isShapeType(nil, "polygon", shape) then
                love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()));
            elseif isShapeType(nil, "circle", shape) then
                love.graphics.circle("fill", body:getX(), body:getY(), shape:getRadius());
            elseif isShapeType(nil, "chain", shape) then
            elseif isShapeType(nil, "edge", shape) then
            end
        end);
    end;
end;
exports.GameObjectRenderer._id = "GameObjectRenderer";
exports.GameObjectRenderer._flag = SystemFlag.GameObjectRenderer;
return exports;
