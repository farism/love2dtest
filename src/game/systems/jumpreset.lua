local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'

local aspect = Aspect:new({Inut, Movement})
local JumpReset = System:new('jumpreset', aspect)

local function getPlayerEntity(a, b)
  if a:getUserData().isPlayer and b:getBody():getType() == Fixture.STATIC then
    return a:getUserData().entity
  end
end

function JumpReset:collision(a, b, contact)
  local entity = getPlayerEntity(a, b) or getPlayerEntity(b, a)

  if entity then
    entity:as(Movement).jumpCount = 0
  end
end

return JumpReset
