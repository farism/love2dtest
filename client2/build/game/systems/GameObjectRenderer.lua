--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_gameobject = require("game.components.gameobject");
local GameObject = __TSTL_gameobject.GameObject;
local __TSTL_flags = require("game.systems.flags");
local Flag = __TSTL_flags.Flag;
local isPolygonShape;
isPolygonShape = function(____, shape)
    return shape:getType() == "polygon";
end;
local isCircleShape;
isCircleShape = function(____, shape)
    return shape:getType() == "circle";
end;
local isChainShape;
isChainShape = function(____, shape)
    return shape:getType() == "edge";
end;
local isEdgeShape;
isEdgeShape = function(____, shape)
    return shape:getType() == "chain";
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
            if isPolygonShape(nil, shape) then
                love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()));
            end
        end);
    end;
end;
exports.GameObjectRenderer._id = "GameObjectRenderer";
exports.GameObjectRenderer._flag = Flag.GameObjectRenderer;
return exports;
