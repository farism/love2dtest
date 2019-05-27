import { Component } from './component'
import { Aliasable } from './types'

type Manager = any

interface UserData {
  [k: string]: any
  blueprint?: string
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

  add = (component: Component) => {
    this.manager.addComponent(this, component)
  }

  addAll = (components: Component[]) => {
    components.forEach(component => this.add(component))
  }

  as = <T>(Class: Aliasable<T>) => {
    const cmp = this.manager.getComponent(this, Class)

    return cmp && ((cmp as unknown) as T)
  }

  clearFlag = (component: Component) => {
    if (!this.has(component)) {
      print(`entity ${this.id} does not have component ${component._flag}`)
    }

    this.components = bit.band(this.components, bit.bnot(component._flag))
  }

  destroy = () => {
    this.manager.removeEntity(this)
  }

  has = (component: Component) => {
    return bit.band(this.components, component._flag) === component._flag
  }

  remove = (component: Component) => {
    this.manager.removeComponent(this, component)
  }

  setFlag = (component: Component) => {
    if (this.has(component)) {
      print(`entity ${this.id} already has component ${this.id}`)
      return
    }

    this.components = bit.bxor(this.components, component._flag)
  }
}
