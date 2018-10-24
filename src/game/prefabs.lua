local Checkpoint = require 'game.components.checkpoint'
local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Player = require 'game.components.player'
local Position = require 'game.components.position'
local Sprite = require 'game.components.sprite'
local Spritesheet = require 'game.components.spritesheet'
local Velocity = require 'game.components.velocity'

local function Prefabs(world)
  local pf = {}

  function pf.player(e)
    return {
      Sprite.new(1, 'assets/sprites/player.png'),
      Input.new(1),
      Position.new(1),
      Velocity.new(1),
      Fixture.new(
        1,
        {isPlayer = true, entity = e},
        {world, 0, 0, Fixture.DYNAMIC},
        {Fixture.RECTANGLE, 32, 32},
        1
      )
    }
  end

  function pf.throwingPick()
    return {
      Position.new(1),
      Velocity.new(1),
      Fixture.new(
        1,
        {},
        {world, 0, 0, Fixture.DYNAMIC},
        {Fixture.RECTANGLE, 5, 5},
        1
      )
    }
  end

  function pf.checkpoint()
    return {
      Checkpoint.new(1),
      Position.new(1)
    }
  end

  function pf.ground()
    return {
      Fixture.new(
        1,
        {},
        {world, 800 / 2, 480 - 15, Fixture.STATIC},
        {Fixture.RECTANGLE, 800, 30}
      )
    }
  end

  return pf
end

return Prefabs
