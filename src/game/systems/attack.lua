local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Input = require 'game.components.input'

local aspect = Aspect:new({Input})
local Attack = System:new('attack', aspect)

local function setCooldowns(dt, input)
  input.shootCooldown = math.max(0, input.shootCooldown - dt)
  input.dashCooldown = math.max(0, input.dashCooldown - dt)
  input.grappleCooldown = math.max(0, input.grappleCooldown - dt)
  input.digCooldown = math.max(0, input.digCooldown - dt)
end

function Attack:update(dt)
  for _, entity in pairs(self.entities) do
    local input = entity:as(Input)

    setCooldowns(dt, input)

    if (input.shoot and input.shootCooldown == 0) then
      print('shooting')
      input.shootCooldown = 0.5
    end

    if (input.dash and input.dashCooldown == 0) then
      print('dashing')
      input.dashCooldown = 3
    end

    if (input.grapple and input.grappleCooldown == 0) then
      print('grappling')
      input.grappleCooldown = 3
    end

    if (input.dig and input.digCooldown == 0) then
      print('digging')
      input.digCooldown = 3
    end
  end
end

return Attack
