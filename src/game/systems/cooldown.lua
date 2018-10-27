local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Cooldown = require 'game.components.cooldown'

local aspect = Aspect:new({Cooldown})
local CooldownSystem = System:new('cooldown', aspect)

function CooldownSystem:update(dt)
  for _, entity in pairs(self.entities) do
    local cooldown = entity:as(Cooldown)

    for key, value in pairs(cooldown.timers) do
      cooldown.timers[key] = math.max(0, value - dt)
    end
  end
end

return CooldownSystem
