local Wall = {}

function Wall.create(world)
  local body = love.physics.newBody(world, 100, 100, 'dynamic')
  local shape = love.physics.newRectangleShape(10, 100)
  local fixture = love.physics.newFixture(body, shape)

  return {
    body = body,
    shape = shape,
    fixture = fixture
  }
end

function Wall.update(wall, dt)
end

function Wall.draw(wall)
  love.graphics.polygon(
    'fill',
    wall.body:getWorldPoints(wall.shape:getPoints())
  )
end

return Wall
