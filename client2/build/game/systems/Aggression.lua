--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local Timer = require("game.utils.timer")
local __TSTL_shape = require("game.utils.shape")
local isPolygonShape = __TSTL_shape.isPolygonShape
local __TSTL_collision = require("game.utils.collision")
local check = __TSTL_collision.check
local hasComponent = __TSTL_collision.hasComponent
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_Aggression = require("game.components.Aggression")
local Aggression = __TSTL_Aggression.Aggression
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local __TSTL_Player = require("game.components.Player")
local Player = __TSTL_Player.Player
local __TSTL_Attack = require("game.components.Attack")
local Attack = __TSTL_Attack.Attack
local isAggression
isAggression = function(____, fixture)
    return fixture:getUserData().isAggression
end
____exports.AggressionSystem = {}
local AggressionSystem = ____exports.AggressionSystem
AggressionSystem.name = "AggressionSystem"
AggressionSystem.__index = AggressionSystem
AggressionSystem.prototype = {}
AggressionSystem.prototype.__index = AggressionSystem.prototype
AggressionSystem.prototype.constructor = AggressionSystem
AggressionSystem.____super = System
setmetatable(AggressionSystem, AggressionSystem.____super)
setmetatable(AggressionSystem.prototype, AggressionSystem.____super.prototype)
function AggressionSystem.new(...)
    local self = setmetatable({}, AggressionSystem.prototype)
    self:____constructor(...)
    return self
end
function AggressionSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.AggressionSystem._id
    self._flag = ____exports.AggressionSystem._flag
    self._aspect = ____exports.AggressionSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local aggression = entity:as(Aggression)
            local gameObject = entity:as(GameObject)
            if aggression and gameObject then
                local position = ({gameObject.fixture:getBody():getPosition()})
                aggression.fixture:getBody():setPosition(unpack(position))
            end
        end)
    end
    self.beginContact = function(____, a, b, contact)
        local result = check(nil, a, b, {
            isAggression,
            hasComponent(nil, Player),
        })
        if result then
            local attacker, target = unpack(result)
            attacker:add(Attack.new(target))
        end
    end
    self.endContact = function(____, a, b, contact)
        local result = check(nil, a, b, {
            isAggression,
            hasComponent(nil, Player),
        })
        if result then
            local attacker, target = unpack(result)
            local aggression = attacker:as(Aggression)
            if aggression then
                Timer:setTimeout(aggression.duration, function()
                    attacker:remove(Attack)
                end)
            end
        end
    end
    self.draw = function()
        self.entities:forEach(function(____, entity)
            local aggression = entity:as(Aggression)
            if aggression then
                local body = aggression.fixture:getBody()
                local shape = aggression.fixture:getShape()
                if isPolygonShape(nil, shape) then
                    local points = ({body:getWorldPoints(shape:getPoints())})
                    love.graphics.setColor(255, 0, 0, 0.25)
                    love.graphics.polygon("fill", unpack(points))
                    love.graphics.setColor(255, 255, 255, 1)
                end
            end
        end)
    end
end
AggressionSystem._id = "Aggression"
AggressionSystem._flag = SystemFlag.Aggression
AggressionSystem._aspect = Aspect.new({
    Aggression,
    GameObject,
    Position,
})
return ____exports
