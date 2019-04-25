import { Manager } from '../ecs/manager'
import { Camera } from './utils/camera'
import * as Factory from './Factory'
import { State } from './State'
import { GameObjectRenderer } from './systems/GameObjectRenderer'

type HUD = any

const initializeBlueprints = (manager: Manager) => {
  ;[Factory.createPlayer, Factory.createGround, Factory.createSlope].forEach(
    fn => fn.call(null, manager)
  )
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

    this.manager = new Manager(this.world)

    this.camera = new Camera('right')

    love.physics.setMeter(256)

    this.manager.addSystem(new GameObjectRenderer())

    initializeBlueprints(this.manager)
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
