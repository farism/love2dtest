local constants = require 'game.components.constants'
local collision = require 'game.utils.collision'

local Aggression = {
  _meta = constants.Aggression
}

function Aggression.new(id, world, entity, x, y, minRange, maxRange, duration)
  minRange = minRange or 250 -- range to trigger aggression
  maxRange = maxRange or 500 -- range to lose aggression
  duration = duration or 3 -- lose aggression after duration

  local body = love.physics.newBody(world, x or 0, y or 0, 'kinematic')
  local shape = love.physics.newRectangleShape(minRange, minRange)
  local fixture = love.physics.newFixture(body, shape, 1)
  fixture:setSensor(true)
  fixture:setCategory(8)
  fixture:setUserData({entity = entity, aggression = true})

  local aggression = {
    _meta = Aggression._meta,
    id = id,
    fixture = fixture,
    minRange = minRange,
    maxRange = maxRange,
    duration = duration
  }

  function aggression:destroy()
    self.fixture:getBody():destroy()
  end

  return aggression
end

return Aggression
