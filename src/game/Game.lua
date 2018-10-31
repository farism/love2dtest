local Manager = require 'ecs.manager'

local Factory = require 'game.factory'
local State = require 'game.state'
local HUD = require 'game.hud.hud'
local Position = require 'game.components.position'
local Ability = require 'game.systems.ability'
local Container = require 'game.systems.container'
local Damage = require 'game.systems.damage'
local Input = require 'game.systems.input'
local InputMovement = require 'game.systems.inputmovement'
local Logger = require 'game.systems.logger'
local JumpReset = require 'game.systems.jumpreset'
local FixtureRender = require 'game.systems.fixturerender'
local SpriteRender = require 'game.systems.spriterender'
local SpritesheetRender = require 'game.systems.spritesheetrender'
local SyncBodyPosition = require 'game.systems.syncbodyposition'
local Timer = require 'game.systems.timer'
local WaypointMovement = require 'game.systems.waypointmovement'

local Game = {}

local function initEntities(factory)
  factory.create(factory.ground())
  factory.create(factory.crate(100))
  factory.create(factory.crate(164))
  factory.create(factory.wall(300))
  factory.create(factory.mob(350))

  return factory.create(factory.player())
end

function Game:new()
  local world = love.physics.newWorld(0, 9.81, true)
  local manager = Manager:new(world)
  local factory = Factory(world, manager)
  local hud = HUD:new()
  local game = {
    state = State.PLAYING,
    hud = hud,
    manager = manager,
    world = world
  }

  love.physics.setMeter(256)

  manager:setFactory(factory)

  world.setCallbacks(
    world,
    function(a, b, contact)
      game:collision(a, b, contact)
    end
  )

  manager:addSystem(Container)
  manager:addSystem(Damage)
  manager:addSystem(Input)
  manager:addSystem(SyncBodyPosition)
  manager:addSystem(InputMovement)
  manager:addSystem(JumpReset)
  manager:addSystem(WaypointMovement)
  manager:addSystem(Ability)
  manager:addSystem(Timer)
  manager:addSystem(FixtureRender)
  manager:addSystem(SpriteRender)
  manager:addSystem(SpritesheetRender)
  manager:addSystem(Logger)

  local player = initEntities(factory)

  function game:setState(state)
    self.state = state
  end

  function game:restart()
    love.load()
  end

  function game:keyboard(key, scancode, isrepeat, ispressed)
    self.manager:keyboard(key, scancode, isrepeat, ispressed)
  end

  function game:mouse(x, y, button, istouch, presses)
    self.manager:mouse(x, y, button, istouch, presses)
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

    if player then
      self.hud:draw(player)
    end
  end

  return game
end

return Game
