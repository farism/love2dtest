local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Timer = require 'game.components.timer'

local aspect = Aspect:new({Timer})
local TimerSystem = System:new('timer', aspect)

function TimerSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local timer = entity:as(Timer)

    for k, v in pairs(timer.timers) do
      timer.timers[k].cooldown = math.max(0, (v.cooldown or 0) - dt)
      timer.timers[k].duration = math.max(0, (v.duration or 0) - dt)
    end
  end
end

return TimerSystem
