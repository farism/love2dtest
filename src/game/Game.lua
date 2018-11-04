local Manager = require 'ecs.manager'

local Factory = require 'game.factory'
local State = require 'game.state'
local HUD = require 'game.hud.hud'
local Camera = require 'game.utils.camera'
local Ability = require 'game.systems.ability'
local AnimateSprite = require 'game.systems.animatesprite'
local Checkpoint = require 'game.systems.checkpoint'
local Container = require 'game.systems.container'
local Damage = require 'game.systems.damage'
local Death = require 'game.systems.death'
local FallDeath = require 'game.systems.falldeath'
local FixtureRender = require 'game.systems.fixturerender'
local GameOver = require 'game.systems.gameover'
local Input = require 'game.systems.input'
local InputMovement = require 'game.systems.inputmovement'
local JumpReset = require 'game.systems.jumpreset'
local Logger = require 'game.systems.logger'
local Projectile = require 'game.systems.projectile'
local Respawn = require 'game.systems.respawn'
local SetCurrentAnimation = require 'game.systems.setcurrentanimation'
local SpriteRender = require 'game.systems.spriterender'
local SyncBodyPosition = require 'game.systems.syncbodyposition'
local Timer = require 'game.systems.timer'
local WaveMovement = require 'game.systems.wavemovement'
local WaypointMovement = require 'game.systems.waypointmovement'

local Game = {}

local function initEntities(factory)
  factory.create(factory.ground())
  factory.create(factory.platform(300, 100))
  factory.create(factory.crate(100))
  factory.create(factory.crate(164))
  factory.create(factory.icicle(300, 200))
  factory.create(factory.saw(-800, 200))
  factory.create(factory.saw2(-600, 200))
  factory.create(factory.saw3(-400, 200))
  factory.create(factory.checkpoint(1, 500))
  factory.create(factory.checkpoint(2, 700, 200))
  factory.create(factory.wall(300))
  -- factory.create(factory.mob(350))

  return factory.create(factory.player())
end

function Game:new()
  local world = love.physics.newWorld(0, 9.81, true)
  local manager = Manager:new(world)
  local factory = Factory(world, manager)
  local hud = HUD.new()
  local camera = Camera.new()
  local game = {
    state = State.PLAYING,
    hud = hud,
    camera = camera,
    manager = manager,
    world = world
  }

  love.physics.setMeter(256)

  world.setCallbacks(
    world,
    function(a, b, contact)
      game:collision(a, b, contact)
    end
  )

  manager:addSystem(SyncBodyPosition)
  manager:addSystem(GameOver)
  manager:addSystem(Input)
  manager:addSystem(Respawn)
  manager:addSystem(InputMovement)
  manager:addSystem(JumpReset)
  manager:addSystem(WaypointMovement)
  manager:addSystem(WaveMovement)
  manager:addSystem(Ability)
  manager:addSystem(Timer)
  manager:addSystem(Damage)
  manager:addSystem(Death)
  manager:addSystem(FallDeath)
  manager:addSystem(Container)
  manager:addSystem(Checkpoint)
  manager:addSystem(Projectile)
  manager:addSystem(FixtureRender)
  manager:addSystem(SpriteRender)
  manager:addSystem(SetCurrentAnimation)
  manager:addSystem(AnimateSprite)
  manager:addSystem(Logger)

  manager:setFactory(factory)

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

      if (player) then
        self.camera:update(dt, player)
      end
    end

    self.hud:update(dt, player, self)
  end

  function game:draw()
    self.camera:set()
    self.manager:draw()
    self.camera:clear()

    if player then
      self.hud:draw(player, self)
    end
  end

  return game
end

return Game
