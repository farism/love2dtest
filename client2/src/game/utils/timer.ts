const _cache: Map<number, Timer> = new Map()

let _nextTimerId = 0

class Timer {
  id: number = 0
  currentTime: number = 0
  timeout: number = 0
  callback: () => void

  constructor(id: number, timeout: number, callback: () => void) {
    this.id = id
    this.timeout = timeout
    this.callback = callback
  }

  update = (dt: number) => {
    if (this.currentTime > this.timeout) {
      return false
    }

    this.currentTime += dt

    if (this.currentTime >= this.timeout) {
      this.callback()
      return true
    }

    return false
  }
}

export const setTimeout = (timeout: number, callback: () => void) => {
  const id = _nextTimerId++

  _cache.set(id, new Timer(id, timeout, callback))

  return id
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
