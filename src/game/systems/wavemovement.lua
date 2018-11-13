local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Wave = require 'game.components.wave'

local aspect = Aspect.new({Fixture, Wave})
local WaveMovement = System:new('wavemovement', aspect)

local time = 0

function WaveMovement:update(dt)
  time = time + dt

  for _, entity in pairs(self.entities) do
    local fixture = entity:as(Fixture)
    local wave = entity:as(Wave)
    local body = fixture.fixture:getBody()

    if wave.type == 'circular' then
      body:setPosition(
        wave.x + math.cos(time * wave.frequency) * wave.amplitude,
        wave.y + math.sin(time * wave.frequency) * wave.amplitude
      )
    elseif wave.type == 'horizontal' then
      body:setX(wave.x + math.cos(time * wave.frequency) * wave.amplitude)
    elseif wave.type == 'vertical' then
      body:setY(wave.y + math.sin(time * wave.frequency) * wave.amplitude)
    end
  end
end

return WaveMovement
