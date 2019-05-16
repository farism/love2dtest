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

  constructor(manager: Manager) {
    this.entities = new Map()
    this.manager = manager
    this.paused = false
  }

  add = (entity: Entity) => {
    this.entities.set(entity.id, entity)
  }

  check = (entity: Entity) => {
    if (this._aspect.check(entity)) {
      if (!this.entities.get(entity.id)) {
        this.onAdd(entity)

        print(
          `entity (id :${entity.id}) is now being processed by system (id: ${
            this._id
          })`
        )
      }

      this.entities.set(entity.id, entity)
    } else {
      if (this.entities.get(entity.id)) {
        this.onRemove(entity)
        print(
          `entity (id :${
            entity.id
          }) is no longer being processed by system (id: ${this._id})`
        )
      }

      this.entities.delete(entity.id)
    }
  }

  keyboard = (
    key: string,
    scancode: Scancode,
    isRepeat: boolean,
    isPressed: boolean
  ) => {}

  mouse = (
    x: number,
    y: number,
    button: number,
    isTouch: boolean,
    isPressed: boolean
  ) => {}

  pause = () => {
    this.paused = true
  }

  remove = (entity: Entity) => {
    this.entities.delete(entity.id)
  }

  resume = () => {
    this.paused = false
  }

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {}

  endContact = (a: Fixture, b: Fixture, contact: Contact) => {}

  draw = () => {}

  onAdd = (entity: Entity) => {}

  onRemove = (entity: Entity) => {}

  update = (dt: number) => {}
}
