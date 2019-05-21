import { Aspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { Aggression } from '../components/Aggression'
import { Attack } from '../components/Attack'
import { GameObject } from '../components/GameObject'
import { Player } from '../components/Player'
import { Position } from '../components/Position'
import { SystemFlag } from '../flags'
import { check, hasComponent } from '../utils/collision'
import { isPolygonShape } from '../utils/shape'

const isAggression = (fixture: Fixture) => {
  return fixture.getUserData().isAggression
}

export class AggressionSystem extends System {
  static _id = 'Aggression'
  _id = AggressionSystem._id

  static _flag = SystemFlag.Aggression
  _flag = AggressionSystem._flag

  static _aspect = new Aspect([Aggression, GameObject, Position])
  _aspect = AggressionSystem._aspect

  update = (dt: number) => {
    this.entities.forEach(entity => {
      const aggression = entity.as(Aggression)
      const gameObject = entity.as(GameObject)

      if (aggression && gameObject) {
        const position = gameObject.fixture.getBody().getPosition()

        aggression.fixture.getBody().setPosition(...position)
      }
    })
  }

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [isAggression, hasComponent(Player)])

    if (result) {
      const [attacker, target] = result

      attacker.add(new Attack(target))
    }
  }

  endContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [isAggression, hasComponent(Player)])

    if (result) {
      const [attacker, target] = result

      const aggression = attacker.as(Aggression)

      if (!aggression) {
        return
      }

      if (aggression) {
        aggression.setDurationTimer(() => {
          attacker.remove(Attack)
        })
      }
    }
  }

  draw = () => {
    this.entities.forEach(entity => {
      const aggression = entity.as(Aggression)

      if (aggression) {
        const body = aggression.fixture.getBody()
        const shape = aggression.fixture.getShape()

        if (isPolygonShape(shape)) {
          const points = body.getWorldPoints(...shape.getPoints())

          love.graphics.setColor(255, 0, 0, 0.25)
          love.graphics.polygon('fill', ...points)
          love.graphics.setColor(255, 255, 255, 1)
        }
      }
    })
  }
}
