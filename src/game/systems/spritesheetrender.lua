local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Position = require 'game.components.position'
local Spritesheet = require 'game.components.spritesheet'

local aspect = Aspect:new({Spritesheet})
local SpritesheetRender = System:new('spritesheetrender', aspect)

function SpritesheetRender:draw()
  for _, entity in pairs(self.entities) do
    local spritesheet = entity:as(Spritesheet)
    local position = entity:as(Position)
    love.graphics.draw(
      spritesheet.image,
      spritesheet.frames[3],
      math.floor(position.x + 0.5),
      math.floor(position.y + 0.5)
    )
  end
end

return SpritesheetRender
