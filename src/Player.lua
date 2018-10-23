local Spritesheet = require('Spritesheet')

local Player = {}

function Player:new(world)
  local player = {}
  setmetatable(player, self)

  function player:jump()
  end

  function player:jumpReset()
  end

  function player:jump()
  end
  -- local body = love.physics.newBody(world, 0, 0, 'dynamic')
  -- body:setLinearDamping(0.1)
  -- body:setFixedRotation(true)

  -- local shape = love.physics.newRectangleShape(16, 22)
  -- local fixture = love.physics.newFixture(body, shape, 1)

  -- fixture:setUserData({player = true})

  -- return {
  --   spritesheet = Spritesheet.create('assets/sprites/player.png', 8, 0.3),
  --   body = body,
  --   shape = shape,
  --   fixture = fixture
  -- }
end

function Player.jump(player)
  if player.jumps < 2 then
    local x, y = player.body:getLinearVelocity()

    player.body:setLinearVelocity(x, -300)
    player.jumps = player.jumps + 1
  end
end

function Player.jumpReset(player)
  player.jumps = 0
end

function Player.update(player, dt)
  local x, y = player.body:getLinearVelocity()

  if love.keyboard.isDown('right') then
    player.body:setLinearVelocity(300, y)
  elseif love.keyboard.isDown('left') then
    player.body:setLinearVelocity(-300, y)
  end

  Spritesheet.update(player.spritesheet, dt)
end

function Player.draw(player)
  Spritesheet.draw(
    player.spritesheet,
    player.body:getX() - 16,
    player.body:getY() - 16
  )

  -- love.graphics.setColor(255, 255, 255, 0.5)

  -- love.graphics.polygon(
  --   'fill',
  --   player.body:getWorldPoints(player.shape:getPoints())
  -- )
end

return Player
