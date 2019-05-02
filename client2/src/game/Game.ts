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

type HUD = any

const initializeBlueprints = (manager: Manager) => {
  const blueprints = [
    Factory.createPlayer,
    Factory.createGround,
    Factory.createSlope,
  ]

  blueprints.forEach(blueprint => blueprint(manager))
}

export class Game {
  camera: Camera
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
    love.physics.setMeter(256)
    this.camera = new Camera('right')
    this.manager = new Manager(this.world)
    this.manager.addSystem(new InputSystem())
    this.manager.addSystem(new InputMovementSystem())
    this.manager.addSystem(new CheckpointSystem())
    this.manager.addSystem(new ProjectileSystem())
    this.manager.addSystem(new JumpResetSystem())
    this.manager.addSystem(new SyncBodyPositionSystem())
    this.manager.addSystem(new RenderSystem())

    initializeBlueprints(this.manager)
  }

  setState = (state: State) => {
    this.state = state
  }

  restart = () => {}

  keyboard = (
    key: string,
    scancode: Scancode,
    isRepeat: boolean,
    isPressed: boolean
  ) => {
    this.manager.keyboard(key, scancode, isRepeat, isPressed)
  }

  mouse = (x: number, y: number, isTouch: boolean) => {
    this.manager.mouse(x, y, isTouch)
  }

  update = (dt: number) => {
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
    // this.camera.clear()

    // if player then
    //       self.hud:draw(player, self)
    //     end
  }
}
