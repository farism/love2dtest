local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Movement = require 'game.components.movement'
local collision = require 'game.utils.collision'

local JumpReset = System:new('jumpreset', Aspect.never())

function JumpReset:beginContact(a, b, contact)
  local entity

  if collision.is('player', a) and collision.isNotDynamic(b) then
    entity = a:getUserData().entity
  elseif collision.is('player', b) and collision.isNotDynamic(a) then
    entity = b:getUserData().entity
  end

  local nx, ny = contact:getNormal()

  if entity and (nx == -1 or nx == 1 or ny < 0) then
    entity:as(Movement).jumpCount = 0
  end
end

return JumpReset
