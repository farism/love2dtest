import { WINDOW_WIDTH, WINDOW_HEIGHT } from '../conf'
import { Entity } from '../ecs/Entity'
import { Component } from '../ecs/Component'
import { GameObject } from './components/gameobject'

interface Manager {
  world: World
  addEntity(entity: Entity): void
  addComponent(entity: Entity, component: Component): void
  createEntity(id?: number): Entity
}

enum BlueprintType {
  Ground = 'ground',
}

interface Blueprint {
  entity: Entity
  components: Component[]
}

export class Factory {
  manager: Manager
  entity: Entity
  body: Body
  shape: PolygonShape
  fixture: Fixture

  constructor(manager: Manager) {
    this.manager = manager
    this.entity = this.manager.createEntity()

    this.body = love.physics.newBody(
      this.manager.world,
      WINDOW_WIDTH / 2,
      WINDOW_HEIGHT - 15,
      'static'
    )

    this.shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30)

    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
  }

  attach = ({ entity, components }: Blueprint) => {
    components.forEach(component =>
      this.manager.addComponent(entity, component)
    )
  }

  ground = (): Blueprint => {
    const entity = this.manager.createEntity()

    entity.userData.blueprint = BlueprintType.Ground

    const body = love.physics.newBody(
      this.manager.world,
      WINDOW_WIDTH / 2,
      WINDOW_HEIGHT - 15,
      'static'
    )

    const shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30)

    const fixture = love.physics.newFixture(body, shape, 1)

    return {
      entity,
      components: [new GameObject(entity, fixture)],
    }
  }

  draw = () => {
    love.graphics.polygon(
      'fill',
      ...this.body.getWorldPoints(...this.shape.getPoints())
    )
  }
}
