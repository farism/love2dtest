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
exports.RenderSystem = exports.RenderSystem or {};
exports.RenderSystem.__index = exports.RenderSystem;
exports.RenderSystem.prototype = exports.RenderSystem.prototype or {};
exports.RenderSystem.prototype.__index = exports.RenderSystem.prototype;
exports.RenderSystem.prototype.constructor = exports.RenderSystem;
exports.RenderSystem.____super = System;
setmetatable(exports.RenderSystem, exports.RenderSystem.____super);
setmetatable(exports.RenderSystem.prototype, exports.RenderSystem.____super.prototype);
exports.RenderSystem.new = function(...)
    local self = setmetatable({}, exports.RenderSystem.prototype);
    self:____constructor(...);
    return self;
end;
exports.RenderSystem.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self._id = exports.RenderSystem._id;
    self._flag = exports.RenderSystem._flag;
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
exports.RenderSystem._id = "RenderSystem";
exports.RenderSystem._flag = SystemFlag.RenderSystem;
return exports;
