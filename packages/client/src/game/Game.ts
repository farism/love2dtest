import { Entity } from '../ecs/Entity'
import { Manager } from '../ecs/manager'
import { Gui } from './gui/Gui'
import { State } from './State'
import { AbilitiesSystem } from './systems/Abilities'
import { AggressionSystem } from './systems/Aggression'
import { AnimateSpriteSystem } from './systems/AnimateSprite'
import { AttackSystem } from './systems/Attack'
import { CheckpointSystem } from './systems/Checkpoint'
import { ContainerSystem } from './systems/Container'
import { DamageSystem } from './systems/Damage'
import { DashSystem } from './systems/Dash'
import { DeathSystem } from './systems/Death'
import { FallDeathSystem } from './systems/FallDeath'
import { GameOverSystem } from './systems/GameOver'
import { InputMovementSystem } from './systems/InputMovement'
import { InputSystem } from './systems/InputSystem'
import { JumpResetSystem } from './systems/JumpReset'
import { MovementValidationSystem } from './systems/MovementValidation'
import { ParallaxRenderSystem } from './systems/ParallaxRender'
import { PlatformSystem } from './systems/Platform'
import { ProjectileSystem } from './systems/ProjectileSystem'
import { RenderSystem } from './systems/RenderSystem'
import { RespawnSystem } from './systems/Respawn'
import { SyncBodyPositionSystem } from './systems/SyncBodyPosition'
import { SyncDirectionSystem } from './systems/SyncDirection'
import { WaypointMovementSystem } from './systems/WaypointMovement'
import { Camera } from './utils/camera'
import * as Factory from './utils/factory'
import * as timer from './utils/timer'

const initializeBlueprints = (manager: Manager) => {
  const blueprints = [
    Factory.createGround,
    Factory.createSlope,
    Factory.createPlatform(200, 300, 400, 20),
    // Factory.createMob(300, 300),
    // Factory.createShieldMob(200, 300),
    Factory.createShootMob(350, 300),
    // Factory.createIcicle(200, 200),
    Factory.createParallax({
      layers: [
        {
          imagePath: 'assets/images/sky.png',
          ratio: 0.1,
        },
        {
          imagePath: 'assets/images/clouds_BG.png',
          ratio: 0.1,
          offsetY: -50,
        },
        {
          imagePath: 'assets/images/mountains.png',
          ratio: 0.125,
          offsetY: -100,
        },
        {
          imagePath: 'assets/images/clouds_MG_3.png',
          ratio: 0.3,
          offsetY: -100,
        },
        {
          imagePath: 'assets/images/clouds_MG_2.png',
          ratio: 0.5,
          offsetY: -125,
        },
        {
          imagePath: 'assets/images/clouds_MG_1.png',
          ratio: 0.6,
          offsetY: -200,
        },
      ],
    }),
  ]

  blueprints.forEach(blueprint => blueprint(manager))
}

export class Game {
  camera: Camera
  gui: Gui
  manager: Manager
  player: Entity
  state: State
  world: World

  constructor() {
    this.world = love.physics.newWorld(0, 9.81 * 30 * 8, true)
    this.world.setCallbacks(
      (a: Fixture, b: Fixture, contact: Contact) => {
        this.manager.beginContact(a, b, contact)
      },
      (a: Fixture, b: Fixture, contact: Contact) => {
        this.manager.endContact(a, b, contact)
      }
    )
    this.camera = new Camera('right')
    this.manager = new Manager(this.world)
    this.manager.addSystems([
      // pre-processors
      new InputSystem(this.manager),
      new GameOverSystem(this.manager),

      // pre-renderers
      new ParallaxRenderSystem(this.manager, this.camera),

      // processors
      new DeathSystem(this.manager),
      new AbilitiesSystem(this.manager),
      new DamageSystem(this.manager),
      new CheckpointSystem(this.manager),
      new ContainerSystem(this.manager),
      new FallDeathSystem(this.manager),
      new InputMovementSystem(this.manager),
      new JumpResetSystem(this.manager),
      new WaypointMovementSystem(this.manager),
      new PlatformSystem(this.manager),
      new ProjectileSystem(this.manager),
      new DashSystem(this.manager),
      new AggressionSystem(this.manager),
      new AttackSystem(this.manager),
      new MovementValidationSystem(this.manager),
      new RespawnSystem(this.manager),

      // post-processors
      new SyncBodyPositionSystem(this.manager),
      new SyncDirectionSystem(this.manager),

      // renderers
      new AnimateSpriteSystem(this.manager),
      new RenderSystem(this.manager),
    ])

    this.player = Factory.createPlayer(this.manager)
    this.gui = new Gui(this.player)

    initializeBlueprints(this.manager)

    this.state = State.PLAYING
  }

  setState = (state: State) => {
    this.state = state
  }

  restart = () => {}

  keypressed = (...args: [KeyConstant, Scancode, boolean]) => {
    this.manager.keypressed(...args)
  }

  keyreleased = (...args: [KeyConstant, Scancode]) => {
    this.manager.keyreleased(...args)
  }

  mousepressed = (...args: [number, number, number, boolean]) => {
    this.manager.mousepressed(...args)
  }

  mousereleased = (...args: [number, number, number, boolean]) => {
    this.manager.mousereleased(...args)
  }

  mousemoved = (x: number, y: number, ...args: any) => {}

  update = (dt: number) => {
    this.gui.update(dt, this)

    if (this.state === State.PLAYING) {
      timer.update(dt)
      this.world.update(dt)
      this.manager.update(dt)

      if (this.player) {
        this.camera.update(this.player)
      }
    }
  }

  draw = () => {
    this.camera.set()
    this.manager.draw()
    this.camera.clear()

    if (this.player) {
      this.gui.draw(this)
    }
  }
}
