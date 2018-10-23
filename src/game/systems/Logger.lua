local Aspect = require('ecs/Aspect')
local IntervalSystem = require('ecs/IntervalSystem')
local Sprite = require('game/components/Sprite')
local constants = require('game/systems/constants')

local Logger = {
  _meta = constants.Logger
}

local function noop()
end

local function update(entities)
  -- print('logger update ', entities)
end

function Logger:new()
  local aspect = Aspect:new()
  local system = IntervalSystem:new('logger', aspect, 1, noop, update, noop)

  return system
end

return Logger
