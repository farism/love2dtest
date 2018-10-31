local Ability = require 'game.components.ability'
local Checkpoint = require 'game.components.checkpoint'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'
local Waypoint = require 'game.components.waypoint'
local Player = require 'game.components.player'
local Position = require 'game.components.position'
local Projectile = require 'game.components.projectile'
local Sprite = require 'game.components.sprite'
local Spritesheet = require 'game.components.spritesheet'
local Timer = require 'game.components.timer'
local Velocity = require 'game.components.velocity'

local types = {
  CHECKPOINT = 'checkpoint',
  CONTAINER = 'container',
  GROUND = 'ground',
  MOB = 'mob',
  PLAYER = 'player',
  THROWING_PICK = 'throwingPick',
  WALL = 'wall'
}

local function Factory(world, manager)
  local factory = {}

  function factory.create(prefab)
    local entity, components = prefab()

    for _, component in pairs(components) do
      entity.manager:addComponent(entity, component)
    end

    return entity
  end

  function factory.player(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.PLAYER
      local body = love.physics.newBody(world, x or 0, y or 0, 'dynamic')
      local shape = love.physics.newRectangleShape(32, 32)
      local fixture = love.physics.newFixture(body, shape, 1)
      fixture:setFilterData(2, 1, 0)

      return entity, {
        Sprite.new(1, 'assets/sprites/player.png'),
        -- Spritesheet.new(1, 'assets/sprites/player.png', 8, 1),
        Input.new(1),
        Ability.new(1),
        Movement.new(1),
        Position.new(1),
        Timer.new(1),
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.mob(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.MOB
      local body = love.physics.newBody(world, x or 0, y or 0, 'dynamic')
      local shape = love.physics.newRectangleShape(32, 32)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Waypoint.new(
          1,
          {
            {x = 500, y = 0, duration = 1000},
            {x = 450, y = 0, duration = 3000},
            {x = 400, y = 0, duration = 1000},
            {x = 500, y = 0, duration = 5000},
            {x = 450, y = 0, duration = 5000},
            {x = 600, y = 0, duration = 5000}
          }
        ),
        Movement.new(1),
        Position.new(1),
        Timer.new(1),
        Velocity.new(1),
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.throwingPick()
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.THROWING_PICK
      local body = love.physics.newBody(world, 0, 0, 'dynamic')
      local shape = love.physics.newRectangleShape(8, 8)
      local fixture = love.physics.newFixture(body, shape, 1)
      fixture:setFilterData(1, 1, 0)

      return entity, {
        Projectile.new(1),
        Position.new(1),
        Velocity.new(1),
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.crate(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.CONTAINER
      local body = love.physics.newBody(world, x or 0, y or 0, 'dynamic')
      local shape = love.physics.newRectangleShape(48, 48)
      local fixture = love.physics.newFixture(body, shape, 1)
      fixture:setFilterData(1, 1, 0)

      return entity, {
        Position.new(1, x, y),
        Velocity.new(1),
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.ground()
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.GROUND
      local body = love.physics.newBody(world, 800 / 2, 480 - 15, 'static')
      local shape = love.physics.newRectangleShape(800, 30)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.wall(x)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.WALL
      local body = love.physics.newBody(world, x, 480 - 130, 'static')
      local shape = love.physics.newRectangleShape(30, 200)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Fixture.new(1, entity, fixture)
      }
    end
  end

  return factory
end

return Factory
