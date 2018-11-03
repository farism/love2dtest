local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Animation = require 'game.components.animation'
local Position = require 'game.components.position'
local Sprite = require 'game.components.sprite'

local aspect = Aspect:new({Position, Sprite})
local SpriteRender = System:new('spriterender', aspect)

function SpriteRender:draw()
  for _, entity in pairs(self.entities) do
    local animation = entity:as(Animation)
    local position = entity:as(Position)
    local sprite = entity:as(Sprite)
    local frame = sprite.frame

    love.graphics.draw(
      sprite.image,
      frame,
      math.floor(position.x + 0.5),
      math.floor(position.y + 0.5)
    )
  end
end

return SpriteRender
