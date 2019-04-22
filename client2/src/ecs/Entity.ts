import { Component } from './component'

interface Manager {
  getComponent(e: Entity, c: Component): Component | undefined
  addComponent(e: Entity, c: Component): void
  removeComponent(e: Entity, c: Component): void
  removeEntity(e: Entity): void
}

interface UserData {
  [k: string]: any
}

interface Aliasable<T> {
  new (...args: any[]): T
  _id: string
  _flag: number
}

export class Entity {
  components: number
  id: number
  manager: Manager
  systems: number
  userData: UserData

  constructor(id: number, manager: Manager, userData: UserData = {}) {
    this.components = 0
    this.id = id
    this.manager = manager
    this.systems = 0
    this.userData = userData
  }

  public add = (component: Component) => {
    this.manager.addComponent(this, component)
  }

  public as = <T>(Class: Aliasable<T>) => {
    const cmp = this.manager.getComponent(this, Class)

    return cmp && ((cmp as unknown) as T)
  }

  public clearFlag = (component: Component) => {
    // if (!this.has(component)) {
    //   print(`entity ${this.id} does not have component ${component._flag}`)
    // }

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
    // if (this.has(component)) {
    //   print(`entity ${this.id} already has component ${this.id}`)
    //   return
    // }

    this.components = bit.bxor(this.components, component._flag)
  }
}
