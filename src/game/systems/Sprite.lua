local Aspect = require('ecs/Aspect')
local System = require('ecs/System')
local Position = require('game/components/Position')
local Sprite = require('game/components/Sprite')
local constants = require('game/systems/constants')

local SpriteSystem = {
  _meta = constants.SpriteSystem
}

local function noop()
end

local function draw(entities)
  for _, entity in pairs(entities) do
    local sprite = entity:as(Sprite)
    local position = entity:as(Position)

    love.graphics.draw(sprite.image, sprite.frame, position.x, position.y)
  end
end

function SpriteSystem:new()
  local aspect = Aspect:new({Sprite, Position})
  local system = System:new('sprite', aspect, noop, noop, draw)

  return system
end

return SpriteSystem
