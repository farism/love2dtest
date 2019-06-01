local cron = require 'src.vendor.cron'
local flag = require 'src.game.utils.flag'
local Aggression = require 'src.game.components.aggression'
local Ability = require 'src.game.components.ability'
local Animation = require 'src.game.components.animation'
local Checkpoint = require 'src.game.components.checkpoint'
local Damage = require 'src.game.components.damage'
local Fixture = require 'src.game.components.fixture'
local Health = require 'src.game.components.health'
local Input = require 'src.game.components.input'
local Movement = require 'src.game.components.movement'
local Waypoint = require 'src.game.components.waypoint'
local Player = require 'src.game.components.player'
local Platform = require 'src.game.components.platform'
local Position = require 'src.game.components.position'
local Projectile = require 'src.game.components.projectile'
local Wave = require 'src.game.components.wave'
local Sprite = require 'src.game.components.sprite'
local Trigger = require 'src.game.components.trigger'

local type = {
  CHECKPOINT = 'checkpoint',
  CONTAINER = 'container',
  GROUND = 'ground',
  ICICLE = 'icicle',
  MOB = 'mob',
  PLATFORM = 'platform',
  PLAYER = 'player',
  SAW = 'saw',
  SHIELD = 'shield',
  SNOWBALL = 'snowball',
  PICK = 'pick',
  THROWING_PICK = 'throwingPick',
  TRIGGER = 'trigger',
  WALL = 'wall'
}

local category = {
  STATIC = 1,
  PLAYER = 2,
  PLAYER_ATTACK = 3,
  ENEMY = 4,
  ENEMY_ATTACK = 5,
  CONTAINER = 6,
  BOMB = 7,
  AGGRESSION = 8
}

local function find(component, components)
  for _, c in pairs(components) do
    if component._meta.id == c._meta.id then
      return c
    end
  end

  return nil
end

local function merge(list1, list2)
  for _, value in ipairs(list1) do
    table.insert(list2, value)
  end
end

local function Factory(world, manager)
  local factory = {}

  function factory.create(prefab)
    local entity, components = prefab()

    for _, component in pairs(components) do
      entity:add(component)
    end

    return entity
  end

  function factory.player(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.PLAYER
      local body = love.physics.newBody(world, x or 0, y or 0, 'dynamic')
      local shape = love.physics.newCircleShape(16)
      local fixture = love.physics.newFixture(body, shape, 1)
      body:setFixedRotation(true)
      fixture:setFriction(1)
      fixture:setCategory(category.PLAYER)
      fixture:setMask(category.ENEMY)

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
        Fixture.new(1, entity, fixture, category.PLAYER, 0),
        Health.new(1, 1, 0),
        Input.new(1),
        Movement.new(1),
        Player.new(1),
        Position.new(1)
      }
    end
  end

  function factory.mob(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.MOB
      local body = love.physics.newBody(world, x or 0, y or 0, 'dynamic')
      local shape = love.physics.newRectangleShape(32, 32)
      local fixture = love.physics.newFixture(body, shape, 1)
      body:setFixedRotation(true)
      fixture:setCategory(category.ENEMY)

      return entity, {
        Fixture.new(1, entity, fixture),
        Health.new(1, 1, 0),
        Movement.new(1),
        Position.new(1)
      }
    end
  end

  function factory.slashMob(x, y)
    return function()
      local pick = factory.create(factory.pick(x, y))
      local entity, components = factory.mob(x, y)()
      local fixture1 = find(Fixture, components)
      local fixture2 = pick:as(Fixture)
      local body1 = fixture1.fixture:getBody()
      local body2 = fixture2.fixture:getBody()
      local joint =
        love.physics.newWeldJoint(
        body1,
        body2,
        -24,
        0,
        0,
        0,
        false,
        math.pi / 2
      )

      merge(
        {
          Ability.new(1):setEnabled('slash', true),
          Aggression.new(1, world, entity, x, y, 250, 100),
          Waypoint.new(
            1,
            50,
            {
              {x = x},
              {x = 100},
              {x = 0},
              {x = 200}
            }
          )
        },
        components
      )

      return entity, components
    end
  end

  function factory.shootMob(x, y)
    return function()
      local entity, components = factory.mob(x, y)()

      merge(
        {
          Ability.new(1):setEnabled('shoot', true),
          Aggression.new(1, world, entity, x, y, 500, 100, 2)
        },
        components
      )

      return entity, components
    end
  end

  function factory.shieldMob(x, y)
    return function()
      local shield = factory.create(factory.shield(x, y))
      local entity, components = factory.mob(x, y)()
      local fixture1 = find(Fixture, components)
      local fixture2 = shield:as(Fixture)
      local body1 = fixture1.fixture:getBody()
      local body2 = fixture2.fixture:getBody()
      local joint = love.physics.newWeldJoint(body1, body2, -24, 0, 0, 0, false)

      merge(
        {
          Aggression.new(1, world, entity, x, y, 300, 20, 2),
          Waypoint.new(
            1,
            50,
            {
              {x = x},
              {x = 100},
              {x = 0},
              {x = 200}
            }
          )
        },
        components
      )

      return entity, components
    end
  end

  function factory.taserMob(x, y)
    return function()
      local entity, components = factory.shieldMob(x, y)()

      merge(
        {
          Ability.new(1):setEnabled('taser', true),
          Aggression.new(1, world, entity, x, y, 300, 100, 2),
          Waypoint.new(
            1,
            50,
            {
              {x = x},
              {x = 100},
              {x = 0},
              {x = 200}
            }
          )
        },
        components
      )

      return entity, components
    end
  end

  function factory.pick(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.SWORD
      local body = love.physics.newBody(world, x or 0, y or 0, 'dynamic')
      local shape = love.physics.newRectangleShape(4, 32)
      local fixture = love.physics.newFixture(body, shape, 1)
      body:setFixedRotation(true)
      fixture:setCategory(category.ENEMY)

      return entity, {
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.shield(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.SHIELD
      local body = love.physics.newBody(world, x or 0, y or 0, 'dynamic')
      local shape = love.physics.newRectangleShape(4, 32)
      local fixture = love.physics.newFixture(body, shape, 1)
      body:setFixedRotation(true)
      fixture:setCategory(category.ENEMY)

      return entity, {
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.throwingPick(origin, x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.THROWING_PICK
      local body = love.physics.newBody(world, x or 0, y or 0, 'dynamic')
      local shape = love.physics.newRectangleShape(8, 8)
      local fixture = love.physics.newFixture(body, shape, 1)
      body:setBullet(true)
      body:setGravityScale(0)
      body:setFixedRotation(true)

      if (origin:has(Player)) then
        fixture:setCategory(category.PLAYER_ATTACK)
        fixture:setMask(category.PLAYER, category.AGGRESSION)
      else
        fixture:setCategory(category.ENEMY_ATTACK)
        fixture:setMask(category.ENEMY, category.AGGRESSION)
      end

      return entity, {
        Damage.new(1, 1),
        Fixture.new(1, entity, fixture),
        Position.new(1),
        Projectile.new(1)
      }
    end
  end

  function factory.crate(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.CONTAINER
      local body = love.physics.newBody(world, x or 0, y or 0, 'dynamic')
      local shape = love.physics.newRectangleShape(48, 48)
      local fixture = love.physics.newFixture(body, shape, 1)
      fixture:setCategory(category.CONTAINER)
      fixture:setMask(category.PLAYER, category.ENEMY, category.ENEMY_ATTACK)

      return entity, {
        Fixture.new(1, entity, fixture),
        Health.new(1, 1, 0),
        Position.new(1, x, y)
      }
    end
  end

  function factory.icicle(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.ICICLE
      local body =
        love.physics.newBody(
        world,
        x or 0,
        y or WINDOW_HEIGHT - 30 - 64,
        'static'
      )
      local shape = love.physics.newRectangleShape(64, 64)
      local fixture = love.physics.newFixture(body, shape, 1)
      fixture:setCategory(category.STATIC)

      return entity, {
        Damage.new(1, 1),
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.saw(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.SAW
      local body =
        love.physics.newBody(
        world,
        x or 0,
        y or WINDOW_HEIGHT - 30 - 64,
        'kinematic'
      )
      local shape = love.physics.newCircleShape(32)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Damage.new(1, 1),
        Fixture.new(1, entity, fixture),
        Movement.new(1),
        Position.new(1),
        Wave.newCircular(1, x or 0, y or 0, 100, 2)
      }
    end
  end

  function factory.saw2(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.SAW
      local body =
        love.physics.newBody(
        world,
        x or 0,
        y or WINDOW_HEIGHT - 30 - 64,
        'kinematic'
      )
      local shape = love.physics.newCircleShape(32)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Damage.new(1, 1),
        Fixture.new(1, entity, fixture),
        Movement.new(1),
        Position.new(1),
        Wave.newHorizontal(1, x or 0, y or 0, 100, 2)
      }
    end
  end

  function factory.saw3(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.SAW
      local body =
        love.physics.newBody(
        world,
        x or 0,
        y or WINDOW_HEIGHT - 30 - 64,
        'kinematic'
      )
      local shape = love.physics.newCircleShape(32)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Damage.new(1, 1),
        Fixture.new(1, entity, fixture),
        Movement.new(1),
        Position.new(1),
        Wave.newVertical(1, x or 0, y or 0, 100, 2)
      }
    end
  end

  function factory.snowball(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.SNOWBALL
      local body =
        love.physics.newBody(
        world,
        x or 0,
        y or WINDOW_HEIGHT - 30 - 64,
        'dynamic'
      )
      local shape = love.physics.newCircleShape(64)
      local fixture = love.physics.newFixture(body, shape, 1)
      fixture:setFriction(1)

      return entity, {
        Damage.new(1, 1),
        Fixture.new(1, entity, fixture),
        Position.new(1)
      }
    end
  end

  function factory.checkpoint(index, x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.CHECKPOINT
      local body = love.physics.newBody(world, x or 0, y or 0, 'static')
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

  function factory.platform(x, y)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.PLATFORM
      local body = love.physics.newBody(world, x or 0, y or 0, 'kinematic')
      local shape = love.physics.newRectangleShape(128, 16)
      local fixture = love.physics.newFixture(body, shape, 100)
      body:setFixedRotation(true)
      fixture:setFriction(1)

      return entity, {
        Fixture.new(1, entity, fixture),
        Movement.new(1),
        Position.new(1),
        Platform.new(1, 1, x, y),
        Waypoint.new(
          1,
          100,
          {
            {x = 450, y = 200},
            {x = 700, y = 200}
          }
        )
      }
    end
  end

  function factory.wall(x)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.WALL
      local body = love.physics.newBody(world, x, WINDOW_HEIGHT - 130, 'static')
      local shape = love.physics.newRectangleShape(30, 200)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.slope()
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.GROUND
      local body = love.physics.newBody(world, 1000, 0, 'static')
      local shape =
        love.physics.newPolygonShape(
        500,
        WINDOW_HEIGHT - 30,
        1500,
        WINDOW_HEIGHT - 130,
        1500,
        WINDOW_HEIGHT - 30
      )
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Fixture.new(1, entity, fixture)
      }
    end
  end

  function factory.trigger(x, y, width, height, type, action)
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.TRIGGER
      local body = love.physics.newBody(world, x, y, 'static')
      local shape = love.physics.newRectangleShape(width, height)
      local fixture = love.physics.newFixture(body, shape, 1)
      fixture:setSensor(true)

      return entity, {
        Fixture.new(1, entity, fixture),
        Trigger.new(1, type, action)
      }
    end
  end

  function factory.ground()
    return function()
      local entity = manager:newEntity()
      entity.meta.type = type.GROUND
      local body =
        love.physics.newBody(
        world,
        WINDOW_WIDTH / 2,
        WINDOW_HEIGHT - 15,
        'static'
      )
      local shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30)
      local fixture = love.physics.newFixture(body, shape, 1)

      return entity, {
        Fixture.new(1, entity, fixture)
      }
    end
  end

  return factory
end

return Factory
