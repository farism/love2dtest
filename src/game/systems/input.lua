local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'

local Input = require 'game.components.input'

local aspect = Aspect:new({Input})
local InputSystem = System:new('input', aspect)

function InputSystem:keyboard(key, scancode, isrepeat, ispressed)
  for _, entity in pairs(self.entities) do
    local input = entity:as(Input)

    if (key == 'a') then
      input.left = ispressed
      input.direction = input.right and 'right' or 'left'
    end

    if (key == 'd') then
      input.right = ispressed
      input.direction = input.left and 'left' or 'right'
    end

    input.jump = key == 'space' and ispressed and input.jumps < 2
    input.shoot = key == 'j' and ispressed
    input.dash = key == 'k' and ispressed
  end
end

-- function InputSystem:mouse(x, y, button, istouch, presses)
--   for _, entity in pairs(self.entities) do
--     local input = entity:as(Input)
--   end
-- end

-- function InputSystem:update(dt)
--   for _, entity in pairs(self.entities) do
--     local input = entity:as(Input)
--   end
-- end

return InputSystem
