local Ground = {}

function Ground.create(world)
  local body = love.physics.newBody(world, 800 / 2, 480 - 30 / 2)
  local shape = love.physics.newRectangleShape(800, 30)
  local fixture = love.physics.newFixture(body, shape)
  fixture:setFriction(1)

  return {
    body = body,
    shape = shape,
    fixture = fixture
  }
end

function Ground.update(ground, dt)
end

function Ground.draw(ground)
  love.graphics.polygon(
    'fill',
    ground.body:getWorldPoints(ground.shape:getPoints())
  )
end

return Ground
