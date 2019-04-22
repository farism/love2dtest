import { Manager } from '../ecs/manager'
import { Camera } from './utils/camera'
import { Factory } from './Factory'
import { State } from './State'
import { GameObjectRenderer } from './systems/GameObjectRenderer'

type HUD = any

const initializeBlueprints = (factory: Factory) => {
  const blueprints = [factory.ground()]

  blueprints.forEach(({ entity, components }) => {
    components.forEach(component => {
      entity.add(component)
    })
  })
}

export class Game {
  camera: Camera
  factory: Factory
  hud: HUD
  manager: Manager
  state: State
  world: World

  constructor() {
    this.state = State.PLAYING

    this.world = love.physics.newWorld(0, 9.81, true)

    this.world.setCallbacks(
      (a: Fixture, b: Fixture, contact: Contact) => {
        this.manager.beginContact(a, b, contact)
      },
      (a: Fixture, b: Fixture, contact: Contact) => {
        this.manager.endContact(a, b, contact)
      }
    )

    this.manager = new Manager(this.world)

    this.factory = new Factory(this.manager)

    this.camera = new Camera('right')

    love.physics.setMeter(256)

    this.manager.addSystem(new GameObjectRenderer())

    initializeBlueprints(this.factory)
  }

  setState = (state: State) => {
    this.state = state
  }

  restart = () => {}

  keyboard = (
    key: string,
    scancode: number,
    isRepeat: boolean,
    isPressed: boolean
  ) => {
    this.manager.keyboard(key, scancode, isRepeat, isPressed)
  }

  mouse = (x: number, y: number, isTouch: boolean, presses: number) => {
    this.manager.mouse(x, y, isTouch, presses)
  }

  update = (dt: number) => {
    this.manager.update(dt)

    if (this.state === State.PLAYING) {
      this.world.update(dt)
      this.manager.update(dt)

      // if (player) then
      //         self.camera:update(dt, player)
      //       end
    }

    // self.hud:update(dt, player, self)
  }

  draw = () => {
    // this.camera.set()
    this.manager.draw()
    this.factory.draw()
    // this.camera.clear()

    // if player then
    //       self.hud:draw(player, self)
    //     end
  }
}

//   local game = {
//     state = State.PLAYING,
//     hud = hud,
//     camera = camera,
//     manager = manager,
//     world = world
//   }

// local Factory = require 'src.game.factory'
// local State = require 'src.game.state'
// local HUD = require 'src.game.hud.hud'
// local Camera = require 'src.game.utils.camera'
// local Ability = require 'src.game.systems.ability'
// local Aggression = require 'src.game.systems.aggression'
// local AnimateSprite = require 'src.game.systems.animatesprite'
// local Attack = require 'src.game.systems.attack'
// local Checkpoint = require 'src.game.systems.checkpoint'
// local Container = require 'src.game.systems.container'
// local Damage = require 'src.game.systems.damage'
// local Dash = require 'src.game.systems.dash'
// local Death = require 'src.game.systems.death'
// local FallDeath = require 'src.game.systems.falldeath'
// local FixtureRender = require 'src.game.systems.fixturerender'
// local GameOver = require 'src.game.systems.gameover'
// local Input = require 'src.game.systems.input'
// local InputMovement = require 'src.game.systems.inputmovement'
// local JumpReset = require 'src.game.systems.jumpreset'
// local Logger = require 'src.game.systems.logger'
// local Projectile = require 'src.game.systems.projectile'
// local Platform = require 'src.game.systems.platform'
// local Respawn = require 'src.game.systems.respawn'
// local SetCurrentAnimation = require 'src.game.systems.setcurrentanimation'
// local SpriteRender = require 'src.game.systems.spriterender'
// local SyncBodyPosition = require 'src.game.systems.syncbodyposition'
// local Trigger = require 'src.game.systems.trigger'
// local WaveMovement = require 'src.game.systems.wavemovement'
// local WaypointMovement = require 'src.game.systems.waypointmovement'

// local Game = {}

// local function initEntities(factory)
//   factory.create(factory.ground())
//   factory.create(factory.slope())
//   factory.create(factory.platform(400, 200))
//   factory.create(factory.crate(100))
//   factory.create(factory.crate(164))
//   factory.create(factory.icicle(300, 200))
//   factory.create(factory.saw(-800, 200))
//   factory.create(factory.saw2(-600, 200))
//   factory.create(factory.saw3(-400, 200))
//   factory.create(factory.checkpoint(1, 500))
//   factory.create(factory.checkpoint(2, 700, 200))
//   factory.create(
//     factory.trigger(
//       1500,
//       200,
//       100,
//       100,
//       'spawn',
//       function()
//         factory.create(factory.snowball(2400, 100))
//       end
//     )
//   )
//   -- factory.create(factory.wall(300))
//   -- factory.create(factory.mob(100, 100))
//   -- factory.create(factory.taserMob(100, 100))
//   factory.create(factory.slashMob(100, 100))
//   -- factory.create(factory.stabMob(100, 100))
//   -- factory.create(factory.shootMob(100, 100))
//   -- factory.create(factory.shieldMob(100, 100))

//   return factory.create(factory.player(-200))
// end

// function Game:new()
//   local world = love.physics.newWorld(0, 9.81, true)
//   local manager = Manager:new(world)
//   local factory = Factory(world, manager)
//   local hud = HUD.new()
//   local camera = Camera.new()
//   local game = {
//     state = State.PLAYING,
//     hud = hud,
//     camera = camera,
//     manager = manager,
//     world = world
//   }

//   manager:addSystem(GameOver)
//   manager:addSystem(SyncBodyPosition)
//   manager:addSystem(Respawn)
//   manager:addSystem(Input)
//   manager:addSystem(InputMovement)
//   manager:addSystem(JumpReset)
//   manager:addSystem(WaypointMovement)
//   manager:addSystem(WaveMovement)
//   manager:addSystem(Aggression)
//   manager:addSystem(Attack)
//   manager:addSystem(Ability)
//   manager:addSystem(Dash)
//   manager:addSystem(Damage)
//   manager:addSystem(Death)
//   manager:addSystem(FallDeath)
//   manager:addSystem(Container)
//   manager:addSystem(Trigger)
//   manager:addSystem(Checkpoint)
//   manager:addSystem(Projectile)
//   manager:addSystem(Platform)
//   manager:addSystem(FixtureRender)
//   manager:addSystem(SpriteRender)
//   manager:addSystem(SetCurrentAnimation)
//   manager:addSystem(AnimateSprite)
//   manager:addSystem(Logger)

//   manager:setFactory(factory)

//   local player = initEntities(factory)

//   end
