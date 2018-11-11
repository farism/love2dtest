local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Checkpoint = require 'game.components.checkpoint'
local Player = require 'game.components.player'
local collision = require 'game.utils.collision'

local CheckpointSystem = System:new('checkpoint', Aspect.always())

local function checkCollision(a, b)
  return a.meta.type == 'player' and b.meta.type == 'checkpoint'
end

local function updateCheckpoint(player, checkpoint)
  player.checkpoint = math.max(player.checkpoint, checkpoint.index)
  checkpoint.visted = true
end

function CheckpointSystem:beginContact(a, b, contact)
  a = a:getUserData().entity
  b = b:getUserData().entity

  if checkCollision(a, b) then
    updateCheckpoint(a:as(Player), b:as(Checkpoint))
  elseif checkCollision(b, a) then
    updateCheckpoint(b:as(Player), a:as(Checkpoint))
  end
end

return CheckpointSystem
