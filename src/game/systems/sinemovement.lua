local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local Sine = require 'game.components.sine'

local aspect = Aspect:new({Fixture, Sine})
local SineMovement = System:new('sinemovement', aspect)

local time = 0

function SineMovement:update(dt)
  for _, entity in pairs(self.entities) do
    local fixture = entity:as(Fixture)
    local sine = entity:as(Sine)
    local body = fixture.fixture:getBody()

    -- body:setPosition(
    --   body:getX() + math.sin(time),
    --   math.sin(time) * sine.amplitude
    -- )

    if sine.type == 'circular' then
      body:setPosition(
        math.cos(time) * sine.amplitude,
        math.sin(time) * sine.amplitude
      )
    elseif sine.type == 'wave' then
      body:setPosition(
        math.sin(time) * sine.amplitude,
        math.sin(time) * sine.amplitude
      )
    end

    time = time + dt
  end
end

return SineMovement
