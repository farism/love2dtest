const _cache: Map<number, Timer> = new Map()

let _nextTimerId = 0

type TimerId = number

type OnCompleteCallback = () => void

type OnUpdateCallback = (currentTime: number) => void

export interface Timer {
  completed: boolean
  currentTime: number
  currentPercent: number
  id: TimerId
  onComplete: OnCompleteCallback
  onUpdate: OnUpdateCallback
  timeout: number
}

export const clearTimeout = (id: TimerId) => {
  _cache.delete(id)
}

export const setTimeout = (
  timeout: number,
  onComplete: OnCompleteCallback,
  onUpdate: OnUpdateCallback = () => {}
): Timer => {
  const id = ++_nextTimerId

  const timer = {
    completed: false,
    currentTime: 0,
    currentPercent: 0,
    id,
    onComplete,
    onUpdate,
    timeout,
  }

  _cache.set(id, timer)

  return timer
}

export const update = (dt: number) => {
  _cache.forEach(timer => {
    if (timer.currentTime >= timer.timeout && timer.completed) {
      return
    }

    timer.currentTime += dt
    timer.currentPercent = Math.min(1, timer.currentTime / timer.timeout)

    if (timer.currentTime >= timer.timeout) {
      clearTimeout(timer.id)
      timer.completed = true
      timer.onUpdate(timer.timeout)
      timer.onComplete()
    } else {
      timer.onUpdate(timer.currentTime)
    }
  })
}
