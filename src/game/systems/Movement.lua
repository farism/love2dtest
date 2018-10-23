local Aspect = require('ecs/Aspect')
local System = require('ecs/System')
local Movement = require('game/components/Movement')
local constants = require('game/systems/constants')

local MovementSystem = {
  _meta = constants.Movement
}

local function noop()
end

function input(key, scancode, isRepeat, isPressed, entities)
  for _, entity in pairs(entities) do
  end
end

function update(dt, entities)
  for _, entity in pairs(entities) do
  end
end

function MovementSystem:new(world)
  local aspect = Aspect:new({Movement})
  local system = System:new('movement', aspect, input, update, noop)

  return system
end

return MovementSystem
