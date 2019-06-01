import { easing, TEasing } from './easing'
import { clearTimeout, setTimeout, Timer } from './timer'

const noop = () => {}

type Properties = { [key: string]: any }

interface TweenOptions {
  easing?: TEasing
  onComplete?: () => void
  onUpdate?: (currentTime: number) => void
}

interface TweenConfig {
  duration: number
  target: any
  from: any
  to: any
  options?: TweenOptions
}

const extractTargetProperties = (source: any, target: any) => {
  const properties: Properties = {}

  if (source) {
    Object.keys(source).forEach(key => {
      properties[key] = target[key]
    })
  }

  return properties
}

export class Tween {
  duration: number
  easing: TEasing
  target: Properties
  from: Properties
  to: Properties
  onComplete: () => void
  onUpdate: (currentTime: number) => void
  timer: Timer

  constructor({ target, duration, from, to = {}, options = {} }: TweenConfig) {
    this.target = target
    this.duration = duration
    this.easing = options.easing || easing.outQuad
    this.onComplete = options.onComplete || noop
    this.onUpdate = options.onUpdate || noop
    this.from = from ? from : extractTargetProperties(to, target)
    this.to = to

    for (let key in this.from) {
      this.target[key] = this.from[key]
    }

    this.timer = setTimeout(
      this.duration,
      () => {
        this.onComplete()
      },
      (currentTime: number) => {
        this.update(currentTime)
      }
    )
  }

  update = (currentTime: number) => {
    const t = this.easing(this.timer.currentTime / this.duration)

    Object.keys(this.to).forEach(key => {
      const from = this.from[key]
      const to = this.to[key]
      const diff = to - from

      this.target[key] = from + diff * t
    })

    this.onUpdate(currentTime)
  }

  kill = () => {
    clearTimeout(this.timer.id)
  }
}

export const to = (
  target: any,
  duration: number,
  to: any,
  options: TweenOptions = {}
) => {
  return new Tween({ target, duration, from: null, to, options })
}
