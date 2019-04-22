import { Aspect } from './Aspect'
import { Entity } from './Entity'

type Manager = any

export class System {
  static _id = 'System'
  _id = System._id

  static _aspect = new Aspect()
  _aspect = System._aspect

  entities: Map<number, Entity>
  manager: Manager
  paused: boolean

  constructor() {
    this.entities = new Map()
    this.manager = null
    this.paused = false
  }

  add = (entity: Entity) => {
    this.entities.set(entity.id, entity)
  }

  check = (entity: Entity) => {
    if (this._aspect.check(entity)) {
      if (!this.entities.get(entity.id)) {
        this.onAdd(entity)
      }

      this.entities.set(entity.id, entity)
    } else {
      if (this.entities.get(entity.id)) {
        this.onRemove(entity)
      }

      this.entities.delete(entity.id)
    }
  }

  keyboard = (
    key: string,
    scancode: number,
    isRepeat: boolean,
    isPressed: boolean
  ) => {}

  mouse = (x: number, y: number, isTouch: boolean, presses: number) => {}

  pause = () => {
    this.paused = true
  }

  remove = (entity: Entity) => {
    this.entities.delete(entity.id)
  }

  resume = () => {
    this.paused = false
  }

  setManager = (manager: Manager) => {
    this.manager = manager
  }

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {}

  endContact = (a: Fixture, b: Fixture, contact: Contact) => {}

  draw = () => {}

  onAdd = (entity: Entity) => {}

  onRemove = (entity: Entity) => {}

  update = (dt: number) => {}
}
