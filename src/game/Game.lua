local Manager = require 'ecs.manager'

local Prefabs = require 'game.prefabs'
local State = require 'game.state'
local HUD = require 'game.hud.hud'
local Input = require 'game.systems.input'
local Logger = require 'game.systems.logger'
local JumpReset = require 'game.systems.jumpreset'
local Movement = require 'game.systems.movement'
local Projectile = require 'game.systems.projectile'
local FixtureRender = require 'game.systems.fixturerender'
local SpriteRender = require 'game.systems.spriterender'

local Game = {}

local function initEntities(manager, world)
  local pf = Prefabs(world)
  local arr = {pf.player, pf.ground}

  for _, prefab in pairs(arr) do
    local e = manager:newEntity()

    for _, component in pairs(prefab(e)) do
      manager:addComponent(e, component)
    end
  end
end

function Game:new()
  local game = {
    state = State.PLAYING,
    hud = HUD:new(),
    manager = Manager:new(),
    world = love.physics.newWorld(0, 9.81, true)
  }

  love.physics.setMeter(128)

  game.world.setCallbacks(
    game.world,
    function(a, b, contact)
      game:collision(a, b, contact)
    end
  )

  game.manager:addSystem(Input)
  game.manager:addSystem(Logger)
  game.manager:addSystem(JumpReset)
  game.manager:addSystem(Movement)
  game.manager:addSystem(Projectile)
  game.manager:addSystem(FixtureRender)
  game.manager:addSystem(SpriteRender)

  initEntities(game.manager, game.world)

  function game:setState(state)
    self.state = state
  end

  function game:restart()
    love.load()
  end

  function game:input(key, scancode, isRepeat, isPressed)
    self.manager:input(key, scancode, isRepeat, isPressed)
  end

  function game:collision(a, b, contact)
    self.manager:collision(a, b, contact)
  end

  function game:update(dt)
    if self.state == State.PLAYING then
      self.world:update(dt)
      self.manager:update(dt)
    end

    self.hud:update(dt, self)
  end

  function game:draw()
    self.manager:draw()
    self.hud:draw()
  end

  return game
end

return Game
