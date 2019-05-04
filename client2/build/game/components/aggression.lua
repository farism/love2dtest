--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
____exports.Aggression = {}
local Aggression = ____exports.Aggression
Aggression.name = "Aggression"
Aggression.__index = Aggression
Aggression.prototype = {}
Aggression.prototype.__index = Aggression.prototype
Aggression.prototype.constructor = Aggression
function Aggression.new(...)
    local self = setmetatable({}, Aggression.prototype)
    self:____constructor(...)
    return self
end
function Aggression.prototype.____constructor(self, world, entity, x, y, width, height, duration)
    self._id = ____exports.Aggression._id
    self._flag = ComponentFlag.Aggression
    self.destroy = function()
        self.fixture:getBody():destroy()
    end
    if x == nil then
        x = 0
    end
    if y == nil then
        y = 0
    end
    if width == nil then
        width = 0
    end
    if height == nil then
        height = 0
    end
    if duration == nil then
        duration = 0
    end
    self.active = false
    self.width = width
    self.height = height
    self.duration = duration
    self.fixture = love.physics.newFixture(love.physics.newBody(world, x, y, "kinematic"), love.physics.newRectangleShape(width, height), 1)
    self.fixture:setSensor(true)
    self.fixture:setCategory(8)
    self.fixture:setUserData({
        entity = entity,
        isAggression = true,
    })
end
Aggression._id = "Aggression"
Aggression._flag = ComponentFlag.Aggression
return ____exports
