local Fixture = require 'game.components.fixture'
local Input = require 'game.components.input'
local Player = require 'game.components.player'
local Position = require 'game.components.position'
local Sprite = require 'game.components.sprite'
local Spritesheet = require 'game.components.spritesheet'
local Velocity = require 'game.components.velocity'

local function Prefabs(world)
  local pf = {}

  function pf.player()
    return {
      Input.new(1),
      Sprite.new(1, 'assets/sprites/player.png'),
      Position.new(1),
      Velocity.new(1),
      Fixture.new(
        1,
        {isPlayer = true, entity = e},
        {world, 0, 0, Fixture.DYNAMIC},
        {Fixture.RECTANGLE, 100, 100},
        1
      )
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
