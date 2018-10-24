local System = require 'ecs.system'

local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'

local JumpReset = System:new('jump_reset')

local function getPlayerEntity(a, b)
  if a:getUserData().isPlayer and b:getBody():getType() == Fixture.STATIC then
    return a:getUserData().entity
  end
end

function JumpReset:collision(a, b, contact)
  local entity = getPlayerEntity(a, b) or getPlayerEntity(b, a)

  print(entity)

  if entity then
    entity:as(Input).jumps = 0
  end
end

return JumpReset
