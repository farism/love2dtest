local Manager = require 'src.ecs.manager'

local Factory = require 'src.game.factory'
local State = require 'src.game.state'
local HUD = require 'src.game.hud.hud'
local Camera = require 'src.game.utils.camera'
local Ability = require 'src.game.systems.ability'
local Aggression = require 'src.game.systems.aggression'
local AnimateSprite = require 'src.game.systems.animatesprite'
local Attack = require 'src.game.systems.attack'
local Checkpoint = require 'src.game.systems.checkpoint'
local Container = require 'src.game.systems.container'
local Damage = require 'src.game.systems.damage'
local Dash = require 'src.game.systems.dash'
local Death = require 'src.game.systems.death'
local FallDeath = require 'src.game.systems.falldeath'
local FixtureRender = require 'src.game.systems.fixturerender'
local GameOver = require 'src.game.systems.gameover'
local Input = require 'src.game.systems.input'
local InputMovement = require 'src.game.systems.inputmovement'
local JumpReset = require 'src.game.systems.jumpreset'
local Logger = require 'src.game.systems.logger'
local Projectile = require 'src.game.systems.projectile'
local Platform = require 'src.game.systems.platform'
local Respawn = require 'src.game.systems.respawn'
local SetCurrentAnimation = require 'src.game.systems.setcurrentanimation'
local SpriteRender = require 'src.game.systems.spriterender'
local SyncBodyPosition = require 'src.game.systems.syncbodyposition'
local Trigger = require 'src.game.systems.trigger'
local WaveMovement = require 'src.game.systems.wavemovement'
local WaypointMovement = require 'src.game.systems.waypointmovement'

local Game = {}

local function initEntities(factory)
  factory.create(factory.ground())
  factory.create(factory.slope())
  factory.create(factory.platform(400, 200))
  factory.create(factory.crate(100))
  factory.create(factory.crate(164))
  factory.create(factory.icicle(300, 200))
  factory.create(factory.saw(-800, 200))
  factory.create(factory.saw2(-600, 200))
  factory.create(factory.saw3(-400, 200))
  factory.create(factory.checkpoint(1, 500))
  factory.create(factory.checkpoint(2, 700, 200))
  factory.create(
    factory.trigger(
      1500,
      200,
      100,
      100,
      'spawn',
      function()
        factory.create(factory.snowball(2400, 100))
      end
    )
  )
  -- factory.create(factory.wall(300))
  -- factory.create(factory.mob(100, 100))
  -- factory.create(factory.taserMob(100, 100))
  factory.create(factory.slashMob(100, 100))
  -- factory.create(factory.stabMob(100, 100))
  -- factory.create(factory.shootMob(100, 100))
  -- factory.create(factory.shieldMob(100, 100))

  return factory.create(factory.player(-200))
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
      game:beginContact(a, b, contact)
    end,
    function(a, b, contact)
      game:endContact(a, b, contact)
    end
  )

  manager:addSystem(GameOver)
  manager:addSystem(SyncBodyPosition)
  manager:addSystem(Respawn)
  manager:addSystem(Input)
  manager:addSystem(InputMovement)
  manager:addSystem(JumpReset)
  manager:addSystem(WaypointMovement)
  manager:addSystem(WaveMovement)
  manager:addSystem(Aggression)
  manager:addSystem(Attack)
  manager:addSystem(Ability)
  manager:addSystem(Dash)
  manager:addSystem(Damage)
  manager:addSystem(Death)
  manager:addSystem(FallDeath)
  manager:addSystem(Container)
  manager:addSystem(Trigger)
  manager:addSystem(Checkpoint)
  manager:addSystem(Projectile)
  manager:addSystem(Platform)
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

  function game:beginContact(a, b, contact)
    self.manager:beginContact(a, b, contact)
  end

  function game:endContact(a, b, contact)
    self.manager:endContact(a, b, contact)
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
