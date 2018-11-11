local constants = require 'game.components.constants'
local collision = require 'game.utils.collision'

local Aggression = {
  _meta = constants.Aggression
}

function Aggression.new(id, world, entity, x, y, width, height, duration)
  width = width or 250 -- width of aggression box
  height = height or 250 -- height of aggression box
  duration = duration or 3 -- lose aggression after duration

  local body = love.physics.newBody(world, x or 0, y or 0, 'kinematic')
  local shape = love.physics.newRectangleShape(width, height)
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
