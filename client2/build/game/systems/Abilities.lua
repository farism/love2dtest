--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Aspect = require("ecs.Aspect")
local Aspect = __TSTL_Aspect.Aspect
local __TSTL_System = require("ecs.System")
local System = __TSTL_System.System
local Timer = require("game.utils.timer")
local Factory = require("game.utils.factory")
local __TSTL_flags = require("game.flags")
local SystemFlag = __TSTL_flags.SystemFlag
local __TSTL_GameObject = require("game.components.GameObject")
local GameObject = __TSTL_GameObject.GameObject
local __TSTL_Abilities = require("game.components.Abilities")
local Abilities = __TSTL_Abilities.Abilities
local AbilityType = __TSTL_Abilities.AbilityType
local Ability = __TSTL_Abilities.Ability
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_Movement = require("game.components.Movement")
local Movement = __TSTL_Movement.Movement
local Direction = __TSTL_Movement.Direction
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local __TSTL_Dash = require("game.components.Dash")
local Dash = __TSTL_Dash.Dash
local __TSTL_Damage = require("game.components.Damage")
local Damage = __TSTL_Damage.Damage
local abilityFunctions = {
    throw = function(____, entity, ability)
        local movement = entity:as(Movement)
        local position = entity:as(Position)
        if not movement or not position then
            return
        end
        local x = position.x
        local y = position.y
        local projectile = Factory:createThrowingPick(entity, x, y)
        local gameObject = projectile:as(GameObject)
        if gameObject then
            local body = gameObject.fixture:getBody()
            if movement.direction == Direction.Left then
                body:setLinearVelocity(-1500, 0)
            else
                body:setLinearVelocity(1500, 0)
            end
        end
    end,
    dash = function(____, entity, ability)
        local gameObject = entity:as(GameObject)
        if not gameObject then
            return
        end
        gameObject.fixture:setCategory(3)
        entity:add(Dash.new())
        entity:add(Damage.new(1))
        ability.timers.duration = Timer:setTimeout(ability.duration, function()
            gameObject.fixture:setCategory(2)
            entity:remove(Dash)
            entity:remove(Damage)
        end)
    end,
    ambush = function(____, entity, ability)
    end,
    grapple = function(____, entity, ability)
    end,
    dig = function(____, entity, ability)
    end,
    shoot = function(____, entity, ability)
    end,
    slash = function(____, entity, ability)
    end,
    stab = function(____, entity, ability)
    end,
    taser = function(____, entity, ability)
    end,
}
____exports.AbilitiesSystem = {}
local AbilitiesSystem = ____exports.AbilitiesSystem
AbilitiesSystem.name = "AbilitiesSystem"
AbilitiesSystem.__index = AbilitiesSystem
AbilitiesSystem.prototype = {}
AbilitiesSystem.prototype.__index = AbilitiesSystem.prototype
AbilitiesSystem.prototype.constructor = AbilitiesSystem
AbilitiesSystem.____super = System
setmetatable(AbilitiesSystem, AbilitiesSystem.____super)
setmetatable(AbilitiesSystem.prototype, AbilitiesSystem.____super.prototype)
function AbilitiesSystem.new(...)
    local self = setmetatable({}, AbilitiesSystem.prototype)
    self:____constructor(...)
    return self
end
function AbilitiesSystem.prototype.____constructor(self, ...)
    System.prototype.____constructor(self, ...)
    self._id = ____exports.AbilitiesSystem._id
    self._flag = ____exports.AbilitiesSystem._flag
    self._aspect = ____exports.AbilitiesSystem._aspect
    self.update = function(____, dt)
        self.entities:forEach(function(____, entity)
            local abilities = entity:as(Abilities)
            if not abilities then
                return
            end
            for _key in pairs(abilities.abilities) do
                local key = _key
                local ability = abilities.abilities[key]
                if ability.activated and not ability.timers.cooldown then
                    ability.timers.cooldown = Timer:setTimeout(ability.cooldown, function()
                        ability.timers.cooldown = nil
                    end)
                    Timer:clearTimeout(ability.timers.castspeed)
                    ability.timers.castspeed = Timer:setTimeout(ability.castspeed, function()
                        ability.timers.castspeed = nil
                        abilityFunctions[key](abilityFunctions, entity, ability)
                    end)
                end
            end
        end)
    end
end
AbilitiesSystem._id = "Abilities"
AbilitiesSystem._flag = SystemFlag.Abilities
AbilitiesSystem._aspect = Aspect.new({Abilities})
return ____exports
