import { Component } from './Component'
import { Entity } from './Entity'
import { System } from './System'

export class Manager {
  components: Map<number, Map<number, Component>>
  entities: Map<number, Entity>
  nextId: number
  systems: System[]
  world: World

  constructor(world: World) {
    this.components = new Map()
    this.entities = new Map()
    this.nextId = 0
    this.systems = []
    this.world = world
  }

  // managing entities

  getNextId = () => {
    return this.nextId++
  }

  createEntity = (id?: number): Entity => {
    const entity = new Entity(id || this.getNextId(), this)

    print(`created entity (id: ${entity.id})`)

    this.addEntity(entity)

    return entity
  }

  getEntity = (id: number) => {
    return this.entities.get(id)
  }

  addEntity = (entity: Entity) => {
    this.check(entity)

    this.entities.set(entity.id, entity)

    print(`added entity (id: ${entity.id})`)
  }

  removeEntity = (entity: Entity) => {
    this.systems.forEach(sys => sys.remove(entity))

    this.removeComponents(entity)
    this.components.delete(entity.id)
    this.entities.delete(entity.id)

    print(`removed entity (id: ${entity.id})`)
  }

  // managing components

  getComponent = (entity: Entity, component: Component) => {
    const components = this.components.get(entity.id)

    return components && components.get(component._flag)
  }

  setComponent = (entity: Entity, component: Component, value: any) => {
    const components = this.components.get(entity.id) || new Map()
    components.set(component._flag, value)
    this.components.set(entity.id, components)
  }

  addComponent = (entity: Entity, component: Component) => {
    entity.setFlag(component)
    this.setComponent(entity, component, component)
    this.check(entity)

    print(`added component (id: ${component._id}) to entity (id: ${entity.id})`)
  }

  removeComponent = (entity: Entity, component: Component) => {
    entity.clearFlag(component)
    this.setComponent(entity, component, null)
    this.check(entity)

    print(
      `removed component (id: ${component._id}) from entity (id: ${entity.id})`
    )
  }

  removeComponents = (entity: Entity) => {
    // (this.components.get(entity.id) || new Map()).values()
    //   function manager:removeComponents(entity)
    //     -- need to make this better
    //     for _, component in pairs(self.components[entity.id] or {}) do
    //       if (component.destroy) then
    //         component:destroy()
    //       end
    //       self:setComponent(entity, component, nil)
    //     end
    //   end
  }

  // managing systems

  addSystem = <T extends System>(system: T) => {
    this.entities.forEach(entity => system.check(entity))
    this.systems.push(system)

    print(`added system (id: ${system._id})`)
  }

  addSystems = <T extends System>(systems: T[]) => {
    systems.forEach(system => {
      this.addSystem(system)
    })
  }

  removeSystem = (system: System) => {
    this.systems = this.systems.filter(s => s._id !== system._id)

    print(`removed system (id: ${system._id})`)
  }

  check = (entity: Entity) => {
    this.systems.forEach(system => system.check(entity))
  }

  // lifecycles

  keypressed = (key: string, scancode: Scancode, isRepeat: boolean) => {
    this.systems.forEach(s => s.keyboard(key, scancode, isRepeat, true))
  }

  keyreleased = (key: string, scancode: Scancode) => {
    this.systems.forEach(s => s.keyboard(key, scancode, false, false))
  }

  mousepressed = (x: number, y: number, button: number, isTouch: boolean) => {
    this.systems.forEach(s => s.mouse(x, y, button, isTouch, true))
  }

  mousereleased = (x: number, y: number, button: number, isTouch: boolean) => {
    this.systems.forEach(s => s.mouse(x, y, button, isTouch, false))
  }

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {
    this.systems.forEach(s => s.beginContact(a, b, contact))
  }

  endContact = (a: Fixture, b: Fixture, contact: Contact) => {
    this.systems.forEach(s => s.endContact(a, b, contact))
  }

  update = (dt: number) => {
    this.systems.forEach(s => s.update(dt))
  }

  draw = () => {
    this.systems.forEach(s => s.draw())
  }
}
