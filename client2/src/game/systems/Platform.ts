import { NeverAspect } from '../../ecs/Aspect'
import { System } from '../../ecs/System'
import { GameObject } from '../components/GameObject'
import { Platform } from '../components/Platform'
import { Player } from '../components/Player'
import { Position } from '../components/Position'
import { Waypoint } from '../components/Waypoint'
import { SystemFlag } from '../flags'
import { check, hasComponent } from '../utils/collision'
import * as Timer from '../utils/timer'

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
    const gameObject = entity.as(GameObject)
    const platform = entity.as(Platform)
    const position = entity.as(Position)
    const waypoint = entity.as(Waypoint)

    if (!gameObject || !position || !platform) {
      return
    }

    const body = gameObject.fixture.getBody()

    if (platform && platform.stableDuration > 0) {
      Timer.setTimeout(platform.stableDuration, () => {
        body.setGravityScale(1)
        body.setType('dynamic')

        if (waypoint) {
          waypoint.active = false
        }

        Timer.setTimeout(platform.resetDuration, () => {
          body.setGravityScale(0)
          body.setPosition(platform.initialX, platform.initialY)
          body.setType('kinematic')

          if (waypoint) {
            waypoint.active = true
          }
        })
      })
    }
  }
}
