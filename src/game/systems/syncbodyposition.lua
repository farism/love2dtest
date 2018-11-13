local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Position = require 'game.components.position'

local aspect = Aspect.new({Fixture, Position})
local SyncBodyPosition = System:new('syncbodyposition', aspect)

function SyncBodyPosition:update(dt)
  for _, entity in pairs(self.entities) do
    local fixture = entity:as(Fixture)
    local position = entity:as(Position)
    local body = fixture.fixture:getBody()
    position.x = body:getX()
    position.y = body:getY()
  end
end

return SyncBodyPosition
