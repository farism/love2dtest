--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_shape = require("game.utils.shape")
local isPolygonShape = __TSTL_shape.isPolygonShape
local isCircleShape = __TSTL_shape.isCircleShape
local isChainShape = __TSTL_shape.isChainShape
local isEdgeShape = __TSTL_shape.isEdgeShape
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
____exports.RenderSystem = {}
local RenderSystem = ____exports.RenderSystem
RenderSystem.name = "RenderSystem"
RenderSystem.__index = RenderSystem
RenderSystem.prototype = {}
RenderSystem.prototype.__index = RenderSystem.prototype
RenderSystem.prototype.constructor = RenderSystem
RenderSystem.____super = System
setmetatable(RenderSystem, RenderSystem.____super)
setmetatable(RenderSystem.prototype, RenderSystem.____super.prototype)
function RenderSystem.new(...)
    local self = setmetatable({}, RenderSystem.prototype)
    self:____constructor(...)
    return self
end
function RenderSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.RenderSystem._id
    self._flag = ____exports.RenderSystem._flag
    self._aspect = ____exports.RenderSystem._aspect
    self.draw = function()
        self.entities:forEach(function(____, entity)
            local gameObject = entity:as(GameObject)
            if not gameObject then
                return
            end
            local body = gameObject.fixture:getBody()
            local shape = gameObject.fixture:getShape()
            if isPolygonShape(nil, shape) then
                love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
            elseif isCircleShape(nil, shape) then
                love.graphics.circle("fill", body:getX(), body:getY(), shape:getRadius())
            elseif isChainShape(nil, shape) then
            elseif isEdgeShape(nil, shape) then
            end
        end)
    end
end
RenderSystem._id = "RenderSystem"
RenderSystem._flag = SystemFlag.RenderSystem
RenderSystem._aspect = Aspect.new({GameObject})
return ____exports
