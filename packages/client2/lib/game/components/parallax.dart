// import { ComponentFlag } from '../flags'
// import { loadImage } from '../utils/asset'
// import { Omit } from '../utils/types'

// interface ParallaxLayer {
//   image: Image
//   imagePath: string
//   offsetX?: number
//   offsetY?: number
//   quad: Quad
//   ratio: number
// }

// export interface ParallaxOptions {
//   layers: Omit<ParallaxLayer, 'image' | 'quad'>[]
// }

// export class Parallax {
//   static _id = 'Parallax'
//   _id = Parallax._id

//   static _flag = ComponentFlag.Parallax
//   _flag = ComponentFlag.Parallax

//   layers: ParallaxLayer[]

//   constructor({ layers }: ParallaxOptions) {
//     this.layers = layers.map(layer => {
//       const image = loadImage(layer.imagePath)
//       image.setWrap('repeat', 'clamp')

//       const quad = love.graphics.newQuad(
//         0,
//         0,
//         10000,
//         love.graphics.getHeight(),
//         image.getWidth(),
//         image.getHeight()
//       )

//       return Object.assign(layer, {
//         image,
//         quad,
//       })
//     })
//   }
// }
