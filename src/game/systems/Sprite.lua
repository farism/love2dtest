local Aspect = require('ecs/Aspect')
local System = require('ecs/System')
local Sprite = require('game/components/Sprite')
local constants = require('game/systems/constants')

local SpriteSystem = {
  _meta = constants.SpriteSystem
}

local function noop()
end

function draw(entities)
  for _, entity in pairs(entities) do
    local sprite = entity:as(Sprite)

    love.graphics.draw(sprite.image, sprite.frame, 0, 0)
  end
end

function SpriteSystem:new()
  local aspect = Aspect:new({Sprite})
  local system = System:new('sprite', aspect, noop, noop, draw)

  return system
end

return SpriteSystem
