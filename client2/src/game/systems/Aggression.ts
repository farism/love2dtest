import { Aspect } from '../../ecs/Aspect'
import { Entity } from '../../ecs/Entity'
import { System } from '../../ecs/System'
import { Aggression } from '../components/Aggression'
import { Attack } from '../components/Attack'
import { GameObject } from '../components/GameObject'
import { Player } from '../components/Player'
import { Position } from '../components/Position'
import { Waypoint } from '../components/Waypoint'
import { SystemFlag } from '../flags'
import { check, hasComponent } from '../utils/collision'
import { isPolygonShape } from '../utils/fixture'

const isAggression = (fixture: Fixture) => {
  return fixture.getUserData().isAggression
}

const setWaypointActive = (active: boolean, entity: Entity) => {
  const waypoint = entity.as(Waypoint)

  if (waypoint) {
    waypoint.active = active
  }
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

      if (!aggression || !gameObject) {
        return
      }

      const position = gameObject.fixture.getBody().getPosition()

      aggression.fixture.getBody().setPosition(...position)
    })
  }

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [isAggression, hasComponent(Player)])

    if (!result) {
      return
    }

    const [attacker, target] = result

    const aggression = attacker.as(Aggression)

    if (!aggression) {
      return
    }

    aggression.clearDurationTimer()

    attacker.add(
      new Attack(aggression.followDistance, aggression.followVelocity, target)
    )

    setWaypointActive(false, attacker)
  }

  endContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [isAggression, hasComponent(Player)])

    if (!result) {
      return
    }

    const [attacker, target] = result

    const aggression = attacker.as(Aggression)

    if (!aggression) {
      return
    }

    aggression.setDurationTimer(() => {
      attacker.remove(Attack)

      setWaypointActive(true, attacker)
    })
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
