local Aspect = require 'ecs.aspect'
local IntervalSystem = require 'ecs.intervalsystem'
local Sprite = require 'game.components.sprite'
local constants = require 'game.systems.constants'

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
