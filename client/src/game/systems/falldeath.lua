local Aspect = require 'src.ecs.aspect'
local System = require 'src.ecs.system'
local Fixture = require 'src.game.components.fixture'
local Health = require 'src.game.components.health'
local Player = require 'src.game.components.player'
local Position = require 'src.game.components.position'

local aspect = Aspect.new({Fixture, Health, Player, Position})
local Death = System:new('falldeath', aspect)

local BUFFER = 100

function Death:update(dt)
  for _, entity in pairs(self.entities) do
    local position = entity:as(Position)

    if position.y > WINDOW_HEIGHT + BUFFER then
      entity:as(Health).hitpoints = 0
    end
  end
end

return Death
