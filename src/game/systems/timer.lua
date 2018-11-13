local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Timer = require 'game.components.timer'

local aspect = Aspect.new({Timer})
local TimerSystem = System:new('timer', aspect)

function TimerSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local timer = entity:as(Timer)

    for _, timer in pairs(timer.timers) do
      for key, value in pairs(timer) do
        timer[key] = math.max(0, (value or 0) - dt)
      end
    end
  end
end

return TimerSystem
