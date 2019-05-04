import { createTimer, Timer } from './timer'
import { Easing } from './easing'

interface TweenOptions {
  duration: number
  easing: Easing
  target: any
  from?: any
  to?: any
  onComplete?: () => void
}

export class Tween {
  timer: Timer
  options: TweenOptions

  constructor(options: TweenOptions) {
    this.options = options

    this.timer = createTimer(
      options.duration,
      options.onComplete ? options.onComplete : () => {}
    )

    if (options.from) {
      for (let key in options.from) {
        options.target[key] = options.from[key]
      }
    }
  }

  update = (dt: number) => {
    this.timer.update(dt)

    this.options.easing && this.options.easing(this.timer.currentTime)
  }
}

export const to = (target: any, duration: number, to: any) => {
  return new Tween({ target, duration, to })
}

export const fromTo = (target: any, duration: number, from: any, to: any) => {
  return new Tween({ target, duration, from, to })
}
