// import { ComponentFlag } from '../flags'

// class Sequence {
//   x: number // sequence starting x position
//   y: number // sequence starting y position
//   width: number // frame width
//   height: number // frame height
//   length: number // number of frames in a sequence
//   duration: number // total duration of sequence

//   frames: Quad[]
//   step: number // duration of each frame

//   constructor(
//     x = 0,
//     y = 0,
//     width = 0,
//     height = 0,
//     spriteWidth = 0,
//     spriteHeight = 0,
//     length = 0,
//     duration = 0
//   ) {
//     this.x = x
//     this.y = y
//     this.width = width
//     this.height = height
//     this.length = length
//     this.duration = duration
//     this.step = duration / length

//     this.frames = Array.from(Array(length)).map(() =>
//       love.graphics.newQuad(
//         x + (this.step - 1) * width,
//         y,
//         width,
//         duration,
//         spriteWidth,
//         spriteHeight
//       )
//     )
//   }
// }

// export class Animation {
//   static _id = 'Animation'
//   _id = Animation._id

//   static _flag = ComponentFlag.Animation
//   _flag = ComponentFlag.Animation

//   elapsedTime: number
//   currentFrame: number
//   currentSequence: number
//   sequences: Sequence[]

//   constructor(sequences: Sequence[] = [], currentSequence: number = 0) {
//     this.elapsedTime = 0
//     this.currentFrame = 1
//     this.currentSequence = currentSequence
//     this.sequences = sequences
//   }
// }
