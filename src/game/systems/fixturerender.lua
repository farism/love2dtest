local Aspect = require 'ecs.aspect'
local System = require 'ecs.system'
local Fixture = require 'game.components.fixture'
local constants = require 'game.systems.constants'

local FixtureRenderSystem = {
  _meta = constants.FixtureRender
}

local function noop()
end

local function draw(entities)
  for _, entity in pairs(entities) do
    local fixture = entity:as(Fixture)
    local body = fixture.fixture:getBody()
    local shape = fixture.fixture:getShape()
    local shapeType = shape:getType()

    if shapeType == Fixture.POLYGON then
      love.graphics.polygon('fill', body:getWorldPoints(shape:getPoints()))
    elseif shapeType == Fixture.CIRCLE then
      love.graphics.circle('fill', body:getX(), body:getY(), shape:getRadius())
    elseif shapeType == Fixture.EDGE then
      -- return love.physics.newEdgeShape(...)
    elseif shapeType == Fixture.CHAIN then
    -- return love.physics.newChainShape(...)
    end
  end
end

function FixtureRenderSystem:new()
  local aspect = Aspect:new({Fixture})
  local system = System:new('fixture_render', aspect, noop, noop, draw)

  return system
end

return FixtureRenderSystem
