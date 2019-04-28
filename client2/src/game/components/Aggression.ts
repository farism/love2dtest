import { ComponentFlag } from '../flags'
import { Entity } from '../../ecs/Entity'

export class Aggression {
  static _id = 'Aggression'
  _id = Aggression._id

  static _flag = ComponentFlag.Aggression
  _flag = ComponentFlag.Aggression

  fixture: Fixture
  width: number
  height: number
  duration: number

  constructor(
    world: World,
    entity: Entity,
    x: number = 0,
    y: number = 0,
    width: number = 0,
    height: number = 0,
    duration: number = 0
  ) {
    this.width = width
    this.height = height
    this.duration = duration

    this.fixture = love.physics.newFixture(
      love.physics.newBody(world, x, y, 'kinematic'),
      love.physics.newRectangleShape(width, height),
      1
    )
    this.fixture.setSensor(true)
    this.fixture.setCategory(8)
    this.fixture.setUserData({ entity: entity, aggression: true })
  }

  destroy = () => {
    this.fixture.getBody().destroy()
  }
}
