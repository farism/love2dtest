local Aspect = require('ecs/Aspect')
local System = require('ecs/System')
local Position = require('game/components/Position')
local Sprite = require('game/components/Sprite')
local constants = require('game/systems/constants')

local SpriteRenderSystem = {
  _meta = constants.SpriteRender
}

local function noop()
end

local function draw(entities)
  for _, entity in pairs(entities) do
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

function SpriteRenderSystem:new()
  local aspect = Aspect:new({Sprite, Position})
  local system = System:new('sprite_render', aspect, noop, noop, draw)

  return system
end

return SpriteRenderSystem
