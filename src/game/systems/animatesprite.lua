local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Animation = require 'game.components.animation'
local Movement = require 'game.components.movement'
local Position = require 'game.components.position'
local Sprite = require 'game.components.sprite'

local aspect = Aspect:new({Animation, Sprite})
local AnimateSprite = System:new('spritesheetrender', aspect)

local function update2(dt, animation)
  local elapsedTime = animation.elapsedTime + dt
  local current = animation.animations[animation.currentAnimation]

  if elapsedTime >= current.step then
    animation.elapsedTime = elapsedTime - current.step

    if (animation.currentFrame == current.length) then
      animation.currentFrame = 1
    else
      animation.currentFrame = animation.currentFrame + 1
    end
  else
    animation.elapsedTime = elapsedTime
  end

  animation.frame = current.frames[animation.currentFrame]
end

function AnimateSprite:update(dt)
  for _, entity in pairs(self.entities) do
    local animation = entity:as(Animation)
    update2(dt, animation)
  end
end

return AnimateSprite
