local constants = require 'game.components.constants'

local Fixture = {
  _meta = constants.Fixture,
  -- body types
  DYNAMIC = 'dynamic',
  STATIC = 'static',
  -- shape types
  RECTANGLE = 'rectangle',
  CIRCLE = 'circle',
  EDGE = 'edge',
  POLYGON = 'polygon',
  CHAIN = 'chain'
}

local function newBody(world, x, y, type)
  return love.physics.newBody(world, x or 0, y or 0, type or Fixture.STATIC)
end

local function newShape(type, ...)
  if type == Fixture.RECTANGLE then
    return love.physics.newRectangleShape(...)
  elseif type == Fixture.CIRCLE then
    return love.physics.newCircleShape(...)
  elseif type == Fixture.EDGE then
    return love.physics.newEdgeShape(...)
  elseif type == Fixture.POLYGON then
    return love.physics.newPolygonShape(...)
  elseif type == Fixture.CHAIN then
    return love.physics.newChainShape(...)
  end
end

function Fixture:raw(id, data, body, shape, density)
  local fixture = love.physics.newFixture(body, shape, density or 1)
  fixture:setUserData(data or {})

  return {
    _meta = Fixture._meta,
    id = id,
    body = body,
    shape = shape,
    fixture = fixture
  }
end

function Fixture:new(id, data, body, shape, density)
  local body = newBody(unpack(body))
  local shape = newShape(unpack(shape))

  return Fixture:raw(id, data, body, shape, density)
end

return Fixture
