import { Entity } from '../../ecs/Entity'
import { ComponentFlag } from '../flags'

export class GameObject {
  static _id = 'GameObject'
  _id = GameObject._id

  static _flag = ComponentFlag.GameObject
  _flag = ComponentFlag.GameObject

  entity: Entity
  fixture: Fixture

  constructor(entity: Entity, fixture: Fixture) {
    this.entity = entity
    this.fixture = fixture

    const data = fixture.getUserData() || {}
    data.entity = this.entity
    fixture.setUserData(data)
    fixture.getBody().setUserData(data)
  }

  destroy = () => {
    this.fixture.getBody().destroy()
  }
}
