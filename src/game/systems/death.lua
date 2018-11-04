local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local State = require 'game.state'
local Health = require 'game.components.health'
local Player = require 'game.components.player'
local Respawn = require 'game.components.respawn'

local aspect = Aspect:new({Health})
local Death = System:new('death', aspect)

function Death:container(dt, entity)
  entity:destroy()
end

function Death:player(dt, entity)
  local health = entity:as(Health)
  local player = entity:as(Player)

  entity.manager:addComponent(entity, Respawn.new(1))
  player.lives = math.max(0, player.lives - 1)
  health.hitpoints = 1
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
