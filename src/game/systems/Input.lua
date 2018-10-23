local Aspect = require('ecs/Aspect')
local System = require('ecs/System')
local Input = require('game/components/Input')
local constants = require('game/systems/constants')

local InputSystem = {}

local function noop()
end

local function input(key, scancode, isRepeat, isPressed, entities)
end

local function update(dt, entities)
  for _, entity in pairs(entities) do
    local input = entity:as(Input)
    input.left = love.keyboard.isDown('left')
    input.right = love.keyboard.isDown('right')
  end
end

function InputSystem:new(world)
  local aspect = Aspect:new({Input})
  local system = System:new('input', aspect, input, update, noop)

  return system
end

return InputSystem
