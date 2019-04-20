local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local Animation = require 'src.game.components.animation'
local Sprite = require 'src.game.components.sprite'

local aspect = Aspect.new({Animation, Sprite})
local AnimateSprite = System:new('animatesprite', aspect)

function AnimateSprite:update(dt)
  for _, entity in pairs(self.entities) do
    local animation = entity:as(Animation)
    local sprite = entity:as(Sprite)
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

    sprite.frame = current.frames[animation.currentFrame]
  end
end

return AnimateSprite
