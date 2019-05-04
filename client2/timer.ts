import { SystemFlag } from '../flags'

// export class Timer {
//   timeout: number = 0
//   currentTime: number = 0

//   constructor(
//     timeout: number,
//   ) {
//     checkPositiveInteger('time', time)
//     checkCallback(callback)

//     this.time = time
//     this.callback = callback
//     this.update = update
//     this.args = args
//   }

//   reset = (currentTime: number = 0) => {
//     checkPositiveInteger('currentTime', currentTime)

//     this.currentTime = currentTime
//   }
// }

// export const newTimer = (
//   time: number,
//   callback: (...args: []) => void,
//   update: (dt: number) => void,
//   ...args: any[]
// ) => {
//   return new Timer(time, callback, update, args)
// }

// const updateAfterTimer = (timer: Timer, dt: number) => {
//   checkPositiveInteger('dt', dt)

//   if (timer.currentTime > timer.time) {
//     return true
//   }

//   timer.currentTime += dt

//   if (timer.currentTime > timer.time) {
//     timer.callback(...timer.args)
//     return true
//   }

//   return false
// }

// const updateEveryTimer = (timer: Timer, dt: number) => {
//   checkPositiveInteger('dt', dt)

//   timer.currentTime += dt

//   while (timer.currentTime >= timer.time) {
//     timer.callback(...timer.args)
//     timer.currentTime -= timer.time
//   }
// }

// const after = (time: number, callback: () => void, ...args: any[]) => {
//   // return newTimer(time, callback, updateAfterTimer, ...args)
// }
// const every = (time: number, callback: () => void, ...args: any[]) => {
//   // return newTimer(time, callback, updateEveryTimer, ...args)
// }
