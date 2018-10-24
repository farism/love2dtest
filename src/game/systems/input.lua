local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'

local Input = require 'game.components.input'

local aspect = Aspect:new({Input})
local InputSystem = System:new('input', aspect)

function InputSystem:keyboard(key, scancode, isrepeat, ispressed)
  for _, entity in pairs(self.entities) do
    local input = entity:as(Input)
    input.jump = key == 'space' and ispressed
    input.shoot = key == 'j' and ispressed
    input.dash = key == 'k' and ispressed
  end
end

function InputSystem:mouse(x, y, button, istouch, presses)
  print(x, y, button, istouch, presses)

  for _, entity in pairs(self.entities) do
    local input = entity:as(Input)
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
