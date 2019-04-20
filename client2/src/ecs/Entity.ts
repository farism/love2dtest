import { Component } from './component'
import { Manager } from './manager'

export class Entity {
  components: number
  id: number
  manager: Manager
  systems: number

  constructor(id: number, manager: Manager, meta?: any) {
    this.components = 0
    this.id = id
    this.manager = manager
    this.systems = 0
  }

  public add = (component: Component) => {
    this.manager.addComponent(this, component)
  }

  public as = <T extends Component>(component: Component) => {
    const cmp = this.manager.getComponent(this, component)

    return cmp && (cmp as T)
  }

  public clearFlag = (component: Component) => {
    if (!this.has(component)) {
      print(`entity ${this.id} does not have component ${component._flag}`)
    }

    this.components = bit.band(this.components, bit.bnot(component._flag))
  }

  public destroy = () => {
    this.manager.removeEntity(this)
  }

  public has = (component: Component) => {
    return bit.band(this.components, component._flag) === component._flag
  }

  public remove = (component: Component) => {
    this.manager.removeComponent(this, component)
  }

  public setFlag = (component: Component) => {
    if (this.has(component)) {
      print(`entity ${this.id} already has component ${this.id}`)
      return
    }

    this.components = bit.bxor(this.components, component._flag)
  }
}
