local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Player = require 'game.components.player'
local Trigger = require 'game.components.trigger'
local collision = require 'game.utils.collision'

local aspect = Aspect.new({Trigger})
local TriggerSystem = System:new('trigger', aspect)

function TriggerSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local trigger = entity:as(Trigger)

    if (trigger.activated and not trigger.executed) then
      trigger.action()
      trigger.executed = true
    end
  end
end

function TriggerSystem:beginContact(a, b, contact)
  a = collision.entity(a)
  b = collision.entity(b)

  if a:has(Trigger) and b:has(Player) then
    a:as(Trigger).activated = true
  elseif b:has(Trigger) and a:has(Player) then
    b:as(Trigger).activated = true
  end
end

return TriggerSystem
