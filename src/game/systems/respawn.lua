local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Checkpoint = require 'game.components.checkpoint'
local Fixture = require 'game.components.fixture'
local Player = require 'game.components.player'
local Position = require 'game.components.position'
local Respawn = require 'game.components.respawn'
local Timer = require 'game.components.timer'

local aspect = Aspect.new({Respawn, Timer})
local RespawnSystem = System:new('respawn', aspect)

function findCheckpoint(entity)
  local player = entity:as(Player)
  local fixture = entity:as(Fixture)

  for _, entity in pairs(entity.manager.entities) do
    local checkpoint = entity:as(Checkpoint)

    if checkpoint and player.checkpoint == checkpoint.index then
      return entity
    end
  end
end

function RespawnSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local player = entity:as(Player)
    local respawn = entity:as(Respawn)
    local timers = entity:as(Timer).timers

    if timers.respawn == nil then
      player.lives = math.max(0, player.lives - 1)
      timers.respawn = {waitTime = respawn.waitTime}
    elseif timers.respawn and timers.respawn.waitTime == 0 then
      timers.respawn = nil

      local checkpoint = findCheckpoint(entity)

      if checkpoint then
        local fixture = entity:as(Fixture)
        local body = fixture.fixture:getBody()
        local position = checkpoint:as(Position)

        body:setType('static')
        body:setPosition(position.x, position.y)
        body:setType('dynamic')
      end

      entity:remove(Respawn)
    end
  end
end

return RespawnSystem
