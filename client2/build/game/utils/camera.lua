--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_conf = require("conf")
local WINDOW_WIDTH = __TSTL_conf.WINDOW_WIDTH
local __TSTL_entity = require("ecs.entity")
local Entity = __TSTL_entity.Entity
local __TSTL_Movement = require("game.components.Movement")
local Movement = __TSTL_Movement.Movement
local __TSTL_Position = require("game.components.Position")
local Position = __TSTL_Position.Position
local __TSTL_tween = require("game.utils.tween")
local Tween = __TSTL_tween.Tween
local LEFT_OFFSET = -WINDOW_WIDTH + 300
local RIGHT_OFFSET = -200
____exports.Camera = {}
local Camera = ____exports.Camera
Camera.name = "Camera"
Camera.__index = Camera
Camera.prototype = {}
Camera.prototype.__index = Camera.prototype
Camera.prototype.constructor = Camera
function Camera.new(...)
    local self = setmetatable({}, Camera.prototype)
    self:____constructor(...)
    return self
end
function Camera.prototype.____constructor(self, initialDirection)
    self.clear = function()
        love.graphics.pop()
    end
    self.set = function()
        love.graphics.push()
        love.graphics.translate(math.floor(-self.x + 0.5), math.floor(-self.y + 0.5))
    end
    self.update = function(____, dt, target)
        local movement = target:as(Movement)
        local position = target:as(Position)
        if not movement or not position then
            return
        end
        local offset = self.offset
        if movement.direction == "left" then
            offset = LEFT_OFFSET
        elseif movement.direction == "right" then
            offset = RIGHT_OFFSET
        end
        if self.direction ~= movement.direction then
            self.tween = Tween.new({
                duration = 3,
                target = self,
                to = {offset = offset},
            })
        end
        self.x = position.x + self.offset
        self.direction = movement.direction
    end
    self.x = 0
    self.y = 0
    self.offset = 0
    self.direction = initialDirection
end
return ____exports
