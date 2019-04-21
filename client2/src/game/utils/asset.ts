const imageCache: Map<string, Image> = new Map()
const audioCache: Map<string, Source> = new Map()

export const loadImage = (filepath: string) => {
  if (imageCache.get(filepath)) {
    return imageCache.get(filepath)
  } else {
    const image = love.graphics.newImage(filepath)
    image.setWrap('repeat', 'repeat')
    imageCache.set(filepath, image)

    return image
  }
}

export const loadAudio = (filepath: string) => {
  if (audioCache.get(filepath)) {
    return audioCache.get(filepath)
  } else {
    const audio = love.audio.newSource(filepath, 'static')
    audioCache.set(filepath, audio)

    return audio
  }
}
