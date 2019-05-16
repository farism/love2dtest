import { Aspect } from './Aspect'
import { Manager } from './Manager'
import { System } from './System'

export class IntervalSystem extends System {
  static _id = 'IntervalSystem'
  _id = IntervalSystem._id

  static _aspect = new Aspect()
  _aspect = IntervalSystem._aspect

  elapsed: number
  interval: number
  onUpdate: any

  constructor(manager: Manager, interval: number, onUpdate: any) {
    super(manager)

    this.interval = interval
    this.elapsed = 0
    this.onUpdate = onUpdate
  }

  public update = (dt: number) => {
    const elapsed = this.elapsed + dt

    if (elapsed >= this.interval) {
      this.elapsed = elapsed - this.interval
      this.onUpdate(this.entities)
    } else {
      this.elapsed = elapsed
    }
  }
}
