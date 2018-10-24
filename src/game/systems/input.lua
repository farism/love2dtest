local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'

local Input = require 'game.components.input'

local aspect = Aspect:new({Input})
local InputSystem = System:new('input', aspect)

function InputSystem:input(key, scancode, isRepeat, isPressed)
  for _, entity in pairs(self.entities) do
    local input = entity:as(Input)
    input.jump = key == 'space' and isPressed
    input.shoot = key == 'j' and isPressed
    input.swing = key == 'k' and isPressed
  end
end

function InputSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local input = entity:as(Input)
    input.left = love.keyboard.isDown('a')
    input.right = love.keyboard.isDown('d')
  end
end

return InputSystem
