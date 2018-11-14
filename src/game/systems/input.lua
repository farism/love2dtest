local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Input = require 'game.components.input'
local Ability = require 'game.components.ability'
local Movement = require 'game.components.movement'

local aspect = Aspect.new({Input, Movement})
local InputSystem = System:new('input', aspect)

local inputs = {
  up = 'w',
  down = 's',
  left = 'a',
  right = 'd',
  jump = 'space',
  throw = 'j',
  dash = 'k',
  grapple = 'g'
}

function InputSystem:keyboard(key, scancode, isrepeat, ispressed)
  for _, entity in pairs(self.entities) do
    local ability = entity:as(Ability)
    local movement = entity:as(Movement)

    if (movement) then
      if (key == inputs.up) then
        movement.lookUp = ispressed
      end

      if (key == inputs.down) then
        movement.lookDown = ispressed
      end

      if (key == inputs.left) then
        movement.left = ispressed
        movement.direction = movement.right and 'right' or 'left'
      end

      if (key == inputs.right) then
        movement.right = ispressed
        movement.direction = movement.left and 'left' or 'right'
      end

      movement.jump =
        key == inputs.jump and ispressed and movement.jumpCount < 2
    end

    if (ability) then
      ability:setActivated('throw', key == inputs.throw and ispressed)
      ability:setActivated('dash', key == inputs.dash and ispressed)
      ability:setActivated('grapple', key == inputs.grapple and ispressed)
    end
  end
end

function InputSystem:mouse(x, y, button, istouch, presses)
  -- for _, entity in pairs(self.entities) do
  -- end
end

function InputSystem:update(dt)
  -- for _, entity in pairs(self.entities) do
  -- end
end

return InputSystem
