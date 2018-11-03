local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Animation = require 'game.components.animation'
local Movement = require 'game.components.movement'

local aspect = Aspect:new({Animation, Movement})
local SetCurrentAnimation = System:new('setcurrentanimation', aspect)

function SetCurrentAnimation:update(dt)
  for _, entity in pairs(self.entities) do
    local animation = entity:as(Animation)
    local movement = entity:as(Movement)

    local action = 'stand'

    if movement.right or movement.left then
      action = 'walk'
    end
    local current = action .. '_' .. movement.direction

    animation.currentFrame = 1
    animation.currentAnimation = current
  end
end

return SetCurrentAnimation
