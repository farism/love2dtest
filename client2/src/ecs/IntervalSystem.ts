import { Aspect } from './Aspect'
import { System } from './System'

export class IntervalSystem extends System {
  elapsed: number
  interval: number
  onUpdate: any

  constructor(id: string, aspect: Aspect, interval: number, onUpdate: any) {
    super(id, aspect)

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
