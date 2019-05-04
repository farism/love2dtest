import { System } from '../../ecs/System'
import { SystemFlag } from '../flags'
import { Aspect } from '../../ecs/Aspect'
import { GameObject } from '../components/GameObject'
import { Wave, WaveType } from '../components/Wave'

export class WaveMovementSystem extends System {
  static _id = 'WaveMovement'
  _id = WaveMovementSystem._id

  static _flag = SystemFlag.WaveMovement
  _flag = WaveMovementSystem._flag

  static _aspect = new Aspect([GameObject, Wave])
  _aspect = WaveMovementSystem._aspect

  time: number = 0

  update = (dt: number) => {
    this.time = this.time + dt

    this.entities.forEach(entity => {
      const wave = entity.as(Wave)
      const gameObject = entity.as(GameObject)

      if (!wave || !gameObject) {
        return
      }

      const step = this.time * wave.frequency
      const body = gameObject.fixture.getBody()

      if (wave.type === WaveType.Circular) {
        body.setPosition(
          wave.x + Math.cos(step) * wave.amplitude,
          wave.y + Math.sin(step) * wave.amplitude
        )
      } else if (wave.type === WaveType.Horizontal) {
        body.setX(wave.x + Math.cos(step) * wave.amplitude)
      } else if (wave.type === WaveType.Vertical) {
        body.setY(wave.y + Math.sin(step) * wave.amplitude)
      }
    })
  }
}
