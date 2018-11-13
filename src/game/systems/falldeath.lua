local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Health = require 'game.components.health'
local Player = require 'game.components.player'
local Position = require 'game.components.position'

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
