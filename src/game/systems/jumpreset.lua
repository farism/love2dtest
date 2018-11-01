local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'

local JumpReset = System:new('jumpreset', Aspect.never())

local function isPlayer(fixture)
  return fixture:getUserData().type == 'player'
end

local function isNotDynamic(fixture)
  return fixture:getBody():getType() ~= 'dynamic'
end

local function getPlayerFixture(a, b)
  if isPlayer(a) then
    return a
  else
    return b
  end
end

local function check(a, b)
  return isPlayer(a) and isNotDynamic(b)
end

function JumpReset:collision(a, b, contact)
  if check(a, b) or check(b, a) then
    local entity = getPlayerFixture(a, b):getUserData().entity

    entity:as(Movement).jumpCount = 0
  end
end

return JumpReset
