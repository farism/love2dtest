import * as Color from '../utils/color'

type DrawQueue = Map<string, () => void>

interface Theme {}

interface ComponentState {
  active: boolean
  clicked: boolean
  focused: boolean
  hovered: boolean
  id: string
  onEnter: boolean
  onLeave: boolean
}

interface ImageButtonOptions {
  image: Image
}

interface Rect {
  height: number
  width: number
  x: number
  y: number
}

interface Component extends Drawable {
  id: string
  z?: number
}

const defaultTheme: Theme = {}

type VerticalAlignMode = 'bottom' | 'middle' | 'top'

const getAlignOffset = (
  valign: VerticalAlignMode,
  height: number,
  font: Font
) => {
  if (valign == 'top') {
    return 0
  } else if (valign == 'bottom') {
    return height - font.getHeight()
  }

  return (height - font.getHeight()) / 2
}

const drawBox = (
  x: number,
  y: number,
  width: number,
  height: number,
  backgroundColor: Color.RGB = Color.hexToRGB('#444'),
  borderRadius: number = 0
) => {
  love.graphics.setColor(backgroundColor)
  love.graphics.rectangle('fill', x, y, width, height, borderRadius)
}

const drawText = (
  x: number,
  y: number,
  text: string,
  width: number = 0,
  align: AlignMode = 'center',
  color: Color.RGB = Color.hexToRGB('#fff'),
  font: Font = love.graphics.getFont() as Font
) => {
  love.graphics.setFont(font)
  love.graphics.setColor(color)
  love.graphics.printf(text, x, y, width, align)
}

const drawLabel = (
  label: string,
  x: number,
  y: number,
  width: number,
  height: number,
  font: Font
) => () => {
  const h = height || font.getHeight()

  drawText(x, y + getAlignOffset('middle', h, font), label, width)
}

const drawButton = (
  label: string,
  x: number,
  y: number,
  width: number,
  height: number,
  font: Font
) => () => {
  drawBox(x, y, width, height)
  drawText(x, y + getAlignOffset('middle', height, font), label, width)
}

const drawImageButton = (
  image: Image,
  x: number,
  y: number,
  scale: number = 1
) => () => {
  love.graphics.draw(image, x, y, 0, scale, scale)
}

const drawCheckbox = (
  x: number,
  y: number,
  label: string,
  width: number
) => () => {
  drawBox(x, y, 16, 16)
  drawText(x + 24, y, label, width - 24, 'left')
}

const contains = (rect: Rect) => (x: number, y: number) => {
  return (
    x > rect.x &&
    x < rect.x + rect.width &&
    y > rect.y &&
    y < rect.y + rect.height
  )
}

export class GuiCore {
  activeId: string = ''
  clickedId: string = ''
  hoveredId: string = ''
  hoveredIdPrev: string = ''
  isMouseDown: boolean = false
  isMouseDownPrev: boolean = false

  drawQueue: DrawQueue = new Map()
  mouseX: number = 0
  mouseY: number = 0

  theme: Theme

  constructor(theme: Theme = defaultTheme) {
    this.theme = theme
  }

  beforeDraw = () => {
    this.hoveredIdPrev = this.hoveredId
    this.isMouseDownPrev = this.isMouseDown

    this.clickedId = ''
    this.hoveredId = ''
    this.isMouseDown = love.mouse.isDown(1)
    this.mouseX = love.mouse.getX()
    this.mouseY = love.mouse.getY()
  }

  draw = () => {
    this.beforeDraw()

    love.graphics.push('all')
    this.drawQueue.forEach(drawFn => drawFn())
    this.drawQueue.clear()
    love.graphics.pop()

    this.afterDraw()
  }

  afterDraw = () => {}

  register = (
    id: string,
    hitbox: (x: number, y: number) => boolean,
    draw: () => void
  ) => {
    this.drawQueue.set(id, draw)

    if (hitbox(this.mouseX, this.mouseY)) {
      this.hoveredId = id

      if (!this.isMouseDownPrev && this.isMouseDown) {
        this.activeId = id
      }

      if (this.isMouseDownPrev && !this.isMouseDown) {
        if (this.activeId == id) {
          this.clickedId = id
        }

        this.activeId = ''
      }
    }
  }

  isClicked = (id: string) => {
    return id === this.clickedId
  }

  wasHovered = (id: string) => {
    return id === this.hoveredIdPrev
  }

  isHovered = (id: string) => {
    return id === this.hoveredId
  }

  isActive = (id: string) => {
    return id === this.activeId
  }

  getComponentState = (id: string): ComponentState => {
    return {
      id,
      focused: false,
      hovered: this.isHovered(id),
      active: this.isActive(id),
      clicked: this.isClicked(id),
      onEnter: !this.wasHovered(id) && this.isHovered(id),
      onLeave: this.wasHovered(id) && !this.isHovered(id),
    }
  }

  label = (
    id: string,
    label: string,
    x: number,
    y: number,
    width: number = 0,
    height: number = 0,
    font: Font = love.graphics.getFont() as Font,
    z: number = 1
  ): ComponentState => {
    const hitbox = contains({ x, y, width, height })

    this.register(id, hitbox, drawLabel(label, x, y, width, height, font))

    return this.getComponentState(id)
  }

  button = (
    id: string,
    label: string = '',
    x: number,
    y: number,
    width: number,
    height: number,
    font: Font = love.graphics.getFont() as Font,
    z: number = 1
  ): ComponentState => {
    const hitbox = contains({ x, y, width, height })

    this.register(id, hitbox, drawButton(label, x, y, width, height, font))

    return this.getComponentState(id)
  }

  imageButton = (
    id: string,
    x: number,
    y: number,
    image: Image,
    scale: number = 1,
    z: number = 1
  ): ComponentState => {
    const width = image.getWidth() * scale
    const height = image.getHeight() * scale
    const hitbox = contains({ x, y, width, height })

    this.register(id, hitbox, drawImageButton(image, x, y, scale))

    return this.getComponentState(id)
  }

  checkbox = (
    id: string,
    label: string = '',
    x: number,
    y: number,
    width = 0,
    z: number = 1
  ): ComponentState => {
    const hitbox = contains({ x, y, width, height: 16 })

    this.register(id, hitbox, drawCheckbox(x, y, label, width))

    return this.getComponentState(id)
  }
}
