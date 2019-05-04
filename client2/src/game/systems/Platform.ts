import { System } from '../../ecs/System'
import * as Timer from '../utils/timer'
import { SystemFlag } from '../flags'
import { NeverAspect } from '../../ecs/Aspect'
import { hasComponent, check } from '../utils/collision'
import { Player } from '../components/Player'
import { Platform } from '../components/Platform'
import { Entity } from '../../ecs/Entity'
import { Position } from '../components/Position'
import { GameObject } from '../components/GameObject'
import { Waypoint } from '../components/Waypoint'

const reset = (
  gameObject: GameObject,
  platform: Platform,
  waypoint: Waypoint
) => () => {
  const body = gameObject.fixture.getBody()
  body.setType('static')
  body.setPosition(platform.initialX, platform.initialY)
  body.setGravityScale(0)
  body.setType('kinematic')

  waypoint.active = true

  delete platform.timer
}

const startFalling = (entity: Entity) => () => {
  const gameObject = entity.as(GameObject)
  const platform = entity.as(Platform)
  const waypoint = entity.as(Waypoint)

  if (!gameObject || !platform || !waypoint) {
    return
  }

  const body = gameObject.fixture.getBody()
  body.setType('dynamic')
  body.setGravityScale(1)

  waypoint.active = false

  platform.timer = Timer.setTimeout(3, reset(gameObject, platform, waypoint))
}

const fall = (entity: Entity) => {
  const platform = entity.as(Platform)
  const position = entity.as(Position)

  if (!position || !platform) {
    return
  }

  platform.initialX = position.x
  platform.initialY = position.y
  platform.timer = Timer.setTimeout(platform.duration, startFalling(entity))
}

export class PlatformSystem extends System {
  static _id = 'Platform'
  _id = PlatformSystem._id

  static _flag = SystemFlag.Platform
  _flag = PlatformSystem._flag

  static _aspect = new NeverAspect()
  _aspect = PlatformSystem._aspect

  beginContact = (a: Fixture, b: Fixture, contact: Contact) => {
    const result = check(a, b, [hasComponent(Platform), hasComponent(Player)])

    if (!result) {
      return
    }

    const entity = result[0]
    const platform = entity.as(Platform)

    if (platform && platform.duration > 0 && !platform.timer) {
      fall(entity)
    }
  }
}
