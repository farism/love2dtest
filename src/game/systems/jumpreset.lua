local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Movement = require 'game.components.movement'
local collision = require 'game.utils.collision'

local JumpReset = System:new('jumpreset', Aspect.never())

function JumpReset:collision(a, b, contact)
  local entity
  if collision.isType('player', a) and collision.isNotDynamic(b) then
    entity = a:getUserData().entity
  elseif collision.isType('player', b) and collision.isNotDynamic(a) then
    entity = b:getUserData().entity
  end

  if entity then
    entity:as(Movement).jumpCount = 0
  end
end

return JumpReset
