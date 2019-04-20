import { Aspect } from './Aspect'
import { Entity } from './Entity'

type Manager = any

export class System {
  id: string
  aspect: Aspect
  entities: Map<number, Entity>
  manager: Manager
  paused: boolean

  constructor(id: string, aspect: Aspect) {
    this.id = id
    this.aspect = aspect || new Aspect()
    this.entities = new Map()
    this.manager = null
    this.paused = false
  }

  public add = (entity: Entity) => {
    this.entities.set(entity.id, entity)
  }

  public check = (entity: Entity) => {
    if (this.aspect.check(entity)) {
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

  public getManager = () => {
    return this.manager
  }

  public keyboard = (
    key: string,
    scancode: number,
    isRepeat: boolean,
    isPressed: boolean
  ) => {}

  public mouse = (x: number, y: number, isTouch: boolean, presses: number) => {}

  public pause = () => {
    this.paused = true
  }

  public remove = (entity: Entity) => {
    this.entities.delete(entity.id)
  }

  public resume = () => {
    this.paused = false
  }

  public setManager = (manager: Manager) => {
    this.manager = manager
  }

  public beginContact = (a: Fixture, b: Fixture, contact: Contact) => {}

  public endContact = (a: Fixture, b: Fixture, contact: Contact) => {}

  public draw = () => {}

  public onAdd = (entity: Entity) => {}

  public onRemove = (entity: Entity) => {}

  public update = (dt: number) => {}
}
