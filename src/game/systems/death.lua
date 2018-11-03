local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local State = require 'game.state'
local Checkpoint = require 'game.components.checkpoint'
local Fixture = require 'game.components.fixture'
local Health = require 'game.components.health'
local Player = require 'game.components.player'
local Position = require 'game.components.position'

local aspect = Aspect:new({Health})
local Death = System:new('death', aspect)

function Death:container(dt, entity)
  entity:destroy()
end

function Death:player(dt, entity)
  local health = entity:as(Health)
  local player = entity:as(Player)
  local fixture = entity:as(Fixture)

  for _, entity in pairs(entity.manager.entities) do
    local checkpoint = entity:as(Checkpoint)

    if checkpoint and player.checkpoint == checkpoint.index then
      local checkpointPosition = entity:as(Position)
      local body = fixture.fixture:getBody()

      body:setPosition(checkpointPosition.x, checkpointPosition.y)
    end
  end

  player.lives = math.max(0, player.lives - 1)
  health.hitpoints = 1

  if (player.lives == 0) then
  -- game:setState(State.GAMEOVER)
  end
end

function Death:update(dt)
  for _, entity in pairs(self.entities) do
    local health = entity:as(Health)

    if (health.hitpoints <= 0) then
      local fn = self[entity.meta.type]

      if (fn) then
        fn(self, dt, entity)
      end
    end
  end
end

return Death
