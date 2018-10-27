local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Position = require 'game.components.position'
local Velocity = require 'game.components.velocity'

local aspect = Aspect:new({Position, Velocity})
local MovementSystem = System:new('movement', aspect)

function MovementSystem:update(dt)
end

return MovementSystem
