local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Snare = require 'game.components.snare'

local aspect = Aspect:new({Snare})
local SnareSystem = System:new('snare', aspect)

function SnareSystem:collision(a, b, contact)
end

return SnareSystem
