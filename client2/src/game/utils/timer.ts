const _cache: Map<number, Timer> = new Map()

let _nextTimerId = 0

export class Timer {
  id: number = 0
  completed: boolean = false
  currentTime: number = 0
  currentPercent: number = 0
  timeout: number = 0
  onComplete: () => void
  onUpdate: (currentTime: number) => void

  constructor(
    id: number,
    timeout: number,
    onComplete: () => void,
    onUpdate: (currentTime: number) => void = (currentTime: number) => {}
  ) {
    this.id = id
    this.timeout = timeout
    this.onComplete = onComplete
    this.onUpdate = onUpdate

    if (this.timeout === 0) {
      this.complete()
    }
  }

  private complete = () => {
    this.completed = true
    this.clear()
    this.onComplete()
  }

  update = (dt: number) => {
    if (this.currentTime >= this.timeout) {
      return false
    }

    this.currentTime += dt
    this.currentPercent = Math.min(1, this.currentTime / this.timeout)

    if (this.currentTime >= this.timeout) {
      this.onUpdate(this.timeout)
      this.complete()
      return true
    } else {
      this.onUpdate(this.currentTime)
    }

    return false
  }

  clear = () => {
    clearTimeout(this.id)
  }
}

export const createTimer = (
  timeout: number,
  onComplete: () => void,
  onUpdate?: (currentTime: number) => void
): Timer => {
  const id = _nextTimerId++
  const timer = new Timer(id, timeout, onComplete, onUpdate)

  _cache.set(id, timer)

  return timer
}

export const setTimeout = (
  timeout: number,
  onComplete: () => void,
  onUpdate?: () => void
): number => {
  return createTimer(timeout, onComplete, onUpdate).id
}

export const clearTimeout = (timerId: number | undefined) => {
  if (typeof timerId === 'number') {
    _cache.delete(timerId)
  }
}

export const update = (dt: number) => {
  _cache.forEach(timer => {
    if (timer.update(dt)) {
      clearTimeout(timer.id)
    }
  })
}
