local Ability = require 'game.components.ability'
local Checkpoint = require 'game.components.checkpoint'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'
local Player = require 'game.components.player'
local Position = require 'game.components.position'
local Projectile = require 'game.components.projectile'
local Sprite = require 'game.components.sprite'
local Spritesheet = require 'game.components.spritesheet'
local Timer = require 'game.components.timer'
local Velocity = require 'game.components.velocity'

local function Factory(world)
  local factory = {}

  function factory.add(entity, components, ...)
    for _, component in pairs(components(entity, ...)) do
      entity.manager:addComponent(entity, component)
    end

    return entity
  end

  function factory.player(e)
    local fixture =
      Fixture.new(
      1,
      {isPlayer = true, entity = e},
      {world, 0, 0, Fixture.DYNAMIC},
      {Fixture.RECTANGLE, 32, 32},
      1
    )

    fixture.fixture:setFilterData(2, 1, 0)

    return {
      Sprite.new(1, 'assets/sprites/player.png'),
      Input.new(1),
      Ability.new(1),
      Movement.new(1),
      Position.new(1),
      Timer.new(1),
      fixture
    }
  end

  function factory.mob(e)
    local fixture =
      Fixture.new(
      1,
      {entity = e},
      {world, 0, 0, Fixture.DYNAMIC},
      {Fixture.RECTANGLE, 32, 32},
      1
    )

    return {
      Position.new(1),
      Velocity.new(1),
      fixture
    }
  end

  function factory.throwingPick(e)
    local fixture =
      Fixture.new(
      1,
      {e = entity},
      {world, 0, 0, Fixture.DYNAMIC},
      {Fixture.RECTANGLE, 8, 8},
      1
    )

    fixture.fixture:setFilterData(1, 1, 0)

    return {
      Projectile.new(1),
      Position.new(1),
      Velocity.new(1),
      fixture
    }
  end

  function factory.crate(e, x, y)
    x = x or 0
    y = y or 0

    local fixture =
      Fixture.new(
      1,
      {},
      {world, x, y, Fixture.DYNAMIC},
      {Fixture.RECTANGLE, 48, 48},
      1
    )

    fixture.fixture:setFilterData(1, 1, 0)

    return {
      Position.new(1, x, y),
      Velocity.new(1),
      fixture
    }
  end

  function factory.ground()
    return {
      Fixture.new(
        1,
        {},
        {world, 800 / 2, 480 - 15, Fixture.STATIC},
        {Fixture.RECTANGLE, 800, 30}
      )
    }
  end

  return factory
end

return Factory
