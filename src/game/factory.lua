local Ability = require 'game.components.ability'
local Cooldown = require 'game.components.cooldown'
local Checkpoint = require 'game.components.checkpoint'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Movement = require 'game.components.movement'
local Player = require 'game.components.player'
local Position = require 'game.components.position'
local Sprite = require 'game.components.sprite'
local Spritesheet = require 'game.components.spritesheet'
local Velocity = require 'game.components.velocity'

local function Factory(world)
  local factory = {}

  function factory.add(entity, components)
    for _, component in pairs(components(entity)) do
      entity.manager:addComponent(entity, component)
    end
  end

  function factory.player(e)
    return {
      Sprite.new(1, 'assets/sprites/player.png'),
      Input.new(1),
      Ability.new(1),
      Cooldown.new(1),
      Movement.new(1),
      Position.new(1),
      Fixture.new(
        1,
        {isPlayer = true, entity = e},
        {world, 0, 0, Fixture.DYNAMIC},
        {Fixture.RECTANGLE, 32, 32},
        1
      )
    }
  end

  function factory.mob(e)
    return {
      Position.new(1),
      Velocity.new(1),
      Fixture.new(
        1,
        {entity = e},
        {world, 0, 0, Fixture.DYNAMIC},
        {Fixture.RECTANGLE, 32, 32},
        1
      )
    }
  end

  function factory.throwingPick()
    return {
      Position.new(1),
      Velocity.new(1),
      Fixture.new(
        1,
        {},
        {world, 0, 0, Fixture.DYNAMIC},
        {Fixture.RECTANGLE, 8, 8},
        1
      )
    }
  end

  function factory.checkpoint()
    return {
      Checkpoint.new(1),
      Position.new(1)
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
