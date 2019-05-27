import { Entity } from '../../ecs/Entity'
import { ComponentFlag } from '../flags'
import { Category } from '../utils/collision'
import * as Timer from '../utils/timer'

export class Aggression {
  static _id = 'Aggression'
  _id = Aggression._id

  static _flag = ComponentFlag.Aggression
  _flag = ComponentFlag.Aggression

  active: boolean
  fixture: Fixture
  width: number
  height: number
  duration: number
  durationTimout: number

  constructor(
    world: World,
    entity: Entity,
    x: number = 0,
    y: number = 0,
    width: number = 0,
    height: number = 0,
    duration: number = 0
  ) {
    this.active = false
    this.width = width
    this.height = height
    this.duration = duration
    this.durationTimout = -1

    this.fixture = love.physics.newFixture(
      love.physics.newBody(world, x, y, 'kinematic'),
      love.physics.newRectangleShape(width, height),
      1
    )
    this.fixture.setSensor(true)
    this.fixture.setCategory(Category.Aggression)
    this.fixture.setUserData({ entity: entity, isAggression: true })
  }

  setDurationTimer = (callback: () => void) => {
    Timer.clearTimeout(this.durationTimout)

    this.durationTimout = Timer.setTimeout(this.duration, callback)
  }

  clearDurationTimer = () => {
    Timer.clearTimeout(this.durationTimout)
  }

  destroy = () => {
    this.fixture.getBody().destroy()
  }
}
