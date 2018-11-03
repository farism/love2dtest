local Ability = require 'game.components.ability'
local Animation = require 'game.components.animation'
local Checkpoint = require 'game.components.checkpoint'
local Damage = require 'game.components.damage'
local Fixture = require 'game.components.fixture'
local Health = require 'game.components.health'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'
local Waypoint = require 'game.components.waypoint'
local Player = require 'game.components.player'
local Position = require 'game.components.position'
local Projectile = require 'game.components.projectile'
local Sine = require 'game.components.sine'
local Sprite = require 'game.components.sprite'
local Spritesheet = require 'game.components.spritesheet'
local Timer = require 'game.components.timer'
local Velocity = require 'game.components.velocity'

local types = {
  CHECKPOINT = 'checkpoint',
  CONTAINER = 'container',
  GROUND = 'ground',
  ICICLE = 'icicle',
  MOB = 'mob',
  PLATFORM = 'platform',
  PLAYER = 'player',
  SAW = 'saw',
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
      fixture:setFriction(1)
      fixture:setFilterData(2, 1, 0)

      local animations = {
        walk_right = {
          x = 0,
          y = 0,
          width = 32,
          height = 32,
          length = 8,
          duration = 1
        },
        walk_left = {
          x = 0,
          y = 32,
          width = 32,
          height = 32,
          length = 8,
          duration = 1
        },
        stand_right = {
          x = 0,
          y = 0,
          width = 32,
          height = 32,
          length = 1,
          duration = 1
        },
        stand_left = {
          x = 0,
          y = 32,
          width = 32,
          height = 32,
          length = 1,
          duration = 1
        }
      }

      local sprite = Sprite.new(1, 'assets/sprites/player.png')
      local spriteWidth, spriteHeight = sprite.image:getDimensions()

      return entity, {
        sprite,
        Animation.new(1, 'walk_right', animations, spriteWidth, spriteHeight),
        Ability.new(1),
        Fixture.new(1, entity, fixture),
        Health.new(1, 1, 0),
        Input.new(1),
        Movement.new(1),
        Player.new(1),
        Position.new(1),
        Timer.new(1)
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
        Fixture.new(1, entity, fixture),
        Movement.new(1),
        Position.new(1),
        Timer.new(1),
        Velocity.new(1),
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
        )
      }
    end
  end

  function factory.platform(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.PLATFORM
      local body = love.physics.newBody(world, x or 0, y or 0, 'kinematic')
      local shape = love.physics.newRectangleShape(128, 128)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Fixture.new(1, entity, fixture),
        Movement.new(1),
        Position.new(1),
        Timer.new(1),
        Velocity.new(1),
        Waypoint.new(
          1,
          {
            {x = 400, y = 0, duration = 1000},
            {x = 600, y = 0, duration = 5000}
          }
        )
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
        Damage.new(1, 1),
        Fixture.new(1, entity, fixture),
        Position.new(1),
        Projectile.new(1),
        Velocity.new(1)
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
        Fixture.new(1, entity, fixture),
        Health.new(1, 1, 0),
        Position.new(1, x, y),
        Velocity.new(1)
      }
    end
  end

  function factory.icicle(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.ICICLE
      local body =
        love.physics.newBody(
        world,
        x or 0,
        y or WINDOW_HEIGHT - 30 - 64,
        'static'
      )
      local shape = love.physics.newRectangleShape(64, 64)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Damage.new(1, 1),
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.saw(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.SAW
      local body =
        love.physics.newBody(
        world,
        x or 0,
        y or WINDOW_HEIGHT - 30 - 64,
        'kinematic'
      )
      local shape = love.physics.newRectangleShape(64, 64)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Damage.new(1, 1),
        Fixture.new(1, entity, fixture),
        Movement.new(1),
        Position.new(1),
        Sine.new(1, 200),
        Timer.new(1),
        Waypoint.new(
          1,
          {
            {x = 400, y = 0, duration = 1000},
            {x = 600, y = 0, duration = 5000}
          }
        )
      }
    end
  end

  function factory.checkpoint(index, x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.CHECKPOINT
      local body =
        love.physics.newBody(
        world,
        x or 0,
        y or WINDOW_HEIGHT - 30 - 64,
        'static'
      )
      local shape = love.physics.newRectangleShape(64, 64)
      local fixture = love.physics.newFixture(body, shape, 1)
      fixture:setSensor(true)

      return entity, {
        Checkpoint.new(1, index),
        Fixture.new(1, entity, fixture),
        Position.new(1)
      }
    end
  end

  function factory.ground()
    return function()
      local entity = manager:newEntity()
      entity.meta.type = types.GROUND
      local body =
        love.physics.newBody(
        world,
        WINDOW_WIDTH / 2,
        WINDOW_HEIGHT - 15,
        'static'
      )
      local shape = love.physics.newRectangleShape(WINDOW_WIDTH, 30)
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
      local body = love.physics.newBody(world, x, WINDOW_HEIGHT - 130, 'static')
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
