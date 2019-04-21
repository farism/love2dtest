import { Component } from '../../ecs/Component'
import { Entity } from '../../ecs/Entity'
import { Flag } from './flags'

export class EntityFixture extends Component {
  static _id = 'EntityFixture'
  _id = EntityFixture._id

  static _flag = Flag.EntityFixture
  _flag = Flag.EntityFixture

  entity: Entity
  fixture: Fixture

  constructor(entity: Entity, fixture: Fixture) {
    super()

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
