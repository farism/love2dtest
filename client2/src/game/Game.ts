import * as timer from './utils/timer'
import * as Factory from './utils/factory'
import { Camera } from './utils/camera'
import { Manager } from '../ecs/manager'
import { InputSystem } from './systems/InputSystem'
import { InputMovementSystem } from './systems/InputMovement'
import { RenderSystem } from './systems/RenderSystem'
import { ProjectileSystem } from './systems/ProjectileSystem'
import { State } from './State'
import { JumpResetSystem } from './systems/JumpReset'
import { SyncBodyPositionSystem } from './systems/SyncBodyPosition'
import { CheckpointSystem } from './systems/Checkpoint'
import { GameOverSystem } from './systems/GameOver'
import { DamageSystem } from './systems/Damage'
import { ContainerSystem } from './systems/Container'
import { AggressionSystem } from './systems/Aggression'
import { AnimateSpriteSystem } from './systems/AnimateSprite'
import { FallDeathSystem } from './systems/FallDeath'
import { AbilitiesSystem } from './systems/Abilities'
import { Entity } from '../ecs/Entity'
import { DashSystem } from './systems/Dash'
import { DeathSystem } from './systems/Death'
import { RespawnSystem } from './systems/Respawn'
import { PlatformSystem } from './systems/Platform'
import { HUD } from './hud/HUD'
import { UI } from './utils/ui'

const initializeBlueprints = (manager: Manager) => {
  const blueprints = [
    Factory.createGround,
    Factory.createSlope,
    Factory.createIcicle(200, 200),
  ]

  blueprints.forEach(blueprint => blueprint(manager))
}

export class Game {
  camera: Camera
  ui: UI
  hud: HUD
  manager: Manager
  player: Entity
  state: State
  world: World

  constructor() {
    this.state = State.PLAYING
    this.world = love.physics.newWorld(0, 9.81, true)
    love.physics.setMeter(256)
    this.world.setCallbacks(
      (a: Fixture, b: Fixture, contact: Contact) => {
        this.manager.beginContact(a, b, contact)
      },
      (a: Fixture, b: Fixture, contact: Contact) => {
        this.manager.endContact(a, b, contact)
      }
    )
    this.ui = new UI()
    this.camera = new Camera('right')
    this.manager = new Manager(this.world)
    this.manager.addSystems([
      // pre-processors
      new InputSystem(),
      new GameOverSystem(),

      // processors
      new AbilitiesSystem(),
      new AggressionSystem(),
      new DamageSystem(),
      new DeathSystem(),
      new CheckpointSystem(),
      new ContainerSystem(),
      new FallDeathSystem(),
      new InputMovementSystem(),
      new JumpResetSystem(),
      new PlatformSystem(),
      new ProjectileSystem(),
      new DashSystem(),
      new RespawnSystem(),

      // post-processors
      new SyncBodyPositionSystem(),

      // renderers
      new AnimateSpriteSystem(),
      new RenderSystem(),
    ])

    this.player = Factory.createPlayer(this.manager)
    this.hud = new HUD(this.player, this.state, this.ui)

    initializeBlueprints(this.manager)
  }

  setState = (state: State) => {
    this.state = state
  }

  restart = () => {}

  keypressed = (...args: [KeyConstant, Scancode, boolean]) => {
    this.manager.keypressed(...args)
    this.ui.keypressed(...args)
  }

  keyreleased = (...args: [KeyConstant, Scancode]) => {
    this.manager.keyreleased(...args)
    this.ui.keyreleased(...args)
  }

  mousepressed = (...args: [number, number, number, boolean]) => {
    this.manager.mousepressed(...args)
    this.ui.mousepressed(...args)
  }

  mousereleased = (...args: [number, number, number, boolean]) => {
    this.manager.mousereleased(...args)
    this.ui.mousereleased(...args)
  }

  mousemoved = (...args: [number, number, number, number, boolean]) => {
    this.ui.mousemoved(...args)
  }

  update = (dt: number) => {
    if (this.state === State.PLAYING) {
      timer.update(dt)
      this.world.update(dt)
      this.manager.update(dt)
      this.ui.update(dt)

      if (this.player) {
        this.camera.update(this.player)
        // this.hud.update(dt)
      }
    }
  }

  draw = () => {
    this.camera.set()
    this.manager.draw()
    this.camera.clear()

    if (this.player) {
      this.hud.draw()
    }
  }
}
