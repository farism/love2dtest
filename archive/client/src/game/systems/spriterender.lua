local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local Position = require 'src.game.components.position'
local Sprite = require 'src.game.components.sprite'

local aspect = Aspect.new({Position, Sprite})
local SpriteRender = System:new('spriterender', aspect)

function SpriteRender:draw()
  for _, entity in pairs(self.entities) do
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
