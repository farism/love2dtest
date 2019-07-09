// import { ComponentFlag } from '../flags'
// import { loadImage } from '../utils/asset'

// export class Sprite {
//   static _id = 'Sprite'
//   _id = Sprite._id

//   static _flag = ComponentFlag.Sprite
//   _flag = ComponentFlag.Sprite

//   filepath: string
//   image?: Image
//   x: number
//   y: number
//   width: number
//   height: number
//   frame: Quad

//   constructor(
//     filepath: string = '',
//     x: number = 0,
//     y: number = 0,
//     width: number = 32,
//     height: number = 32
//   ) {
//     this.filepath = filepath
//     this.x = x
//     this.y = y
//     this.width = width
//     this.height = height
//     this.image = loadImage(filepath)

//     const [sw, sh] = this.image ? this.image.getDimensions() : [32, 32]

//     this.frame = love.graphics.newQuad(x, y, width, height, sw, sh)
//   }
// }
