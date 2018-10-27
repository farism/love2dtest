local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Position = require 'game.components.position'
local Sprite = require 'game.components.sprite'

local aspect = Aspect:new({Sprite})
local SpriteRender = System:new('spriterender', aspect)

function SpriteRender:draw()
  for _, entity in pairs(self.entities) do
    local sprite = entity:as(Sprite)
    local position = entity:as(Position)

    love.graphics.draw(
      sprite.image,
      sprite.frame,
      math.floor(position.x + 0.5),
      math.floor(position.y + 0.5)
    )
  end
end

return SpriteRender
