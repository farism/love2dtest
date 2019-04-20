local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local Fixture = require 'src.game.components.fixture'
local Movement = require 'src.game.components.movement'
local Player = require 'src.game.components.movement'
local collision = require 'src.game.utils.collision'

local JumpReset = System:new('jumpreset', Aspect.never())

function JumpReset:beginContact(a, b, contact)
  local nx, ny = contact:getNormal()

  local entities =
    collision.check(
    a,
    b,
    {collision.hasComponent(Player), collision.isNotBodyType('dynamic')}
  )

  if entities and (nx == -1 or nx == 1 or ny < 0) then
    entities[1]:as(Movement).jumpCount = 0
  end
end

return JumpReset
