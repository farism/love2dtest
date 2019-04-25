// local Aspect = require 'src.ecs.aspect'
// local System = require 'src.ecs.system'
// local Player = require 'src.game.components.player'
// local Trigger = require 'src.game.components.trigger'
// local collision = require 'src.game.utils.collision'

// local aspect = Aspect.new({Trigger})
// local TriggerSystem = System:new('trigger', aspect)

// function TriggerSystem:update(dt)
//   for _, entity in pairs(self.entities) do
//     local trigger = entity:as(Trigger)

//     if (trigger.activated and not trigger.executed) then
//       trigger.action()
//       trigger.executed = true
//     end
//   end
// end

// function TriggerSystem:beginContact(a, b, contact)
//   a = collision.entity(a)
//   b = collision.entity(b)

//   if a:has(Trigger) and b:has(Player) then
//     a:as(Trigger).activated = true
//   elseif b:has(Trigger) and a:has(Player) then
//     b:as(Trigger).activated = true
//   end
// end

// return TriggerSystem
