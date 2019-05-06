import * as Color from './color'
import { draw } from '../hud/stats'

interface Rect {
  x: number
  y: number
  width: number
  height: number
}

type UIDrawQueue = Map<string, [Rect, (options: any) => void]>

interface UITheme {
  color: {
    background: Color.RGB
  }
  borderRadius: number
}

interface UIComponent {
  id?: string
  z?: number
}

interface UIComponentState {
  id: string
  isFocused: boolean
  isHovered: boolean
  isPressed: boolean
  onEnter: boolean
  onLeave: boolean
}

interface UIBox extends Rect {}

interface UIButton extends UIBox, UIComponent {
  text: string
}

const defaultUITheme: UITheme = {
  color: {
    background: Color.hexToRGB('#FF0000'),
  },
  borderRadius: 5,
}

const drawBox = ({ x, y, width, height }: UIBox, theme: UITheme) => {
  love.graphics.setColor(theme.color.background)
  love.graphics.rectangle('fill', x, y, width, height, theme.borderRadius)
}

const drawButton = (options: UIButton) => (theme: UITheme) => {
  drawBox(options, theme)
}

const getHovered = (drawQueue: UIDrawQueue) => {
  let id

  drawQueue.forEach(([rect]) => {})
}

const isHovered = (id: string, drawQueue: UIDrawQueue) => {
  drawQueue.forEach(([rect]) => {})

  return false
}

export class UI {
  theme: UITheme
  mouseX: number = 0
  mouseY: number = 0
  mouseButton: number = 0
  drawQueue: UIDrawQueue = new Map()

  constructor(theme: UITheme = defaultUITheme) {
    this.theme = theme
  }

  keypressed = (key: KeyConstant, scancode: Scancode, isRepeat: boolean) => {}

  keyreleased = (key: KeyConstant, scancode: Scancode) => {}

  mousepressed = (x: number, y: number, button: number, isTouch: boolean) => {
    this.mouseButton = button
  }

  mousereleased = (x: number, y: number, button: number, isTouch: boolean) => {}

  mousemoved = (
    x: number,
    y: number,
    dx: number,
    dy: number,
    isTouch: boolean
  ) => {
    this.mouseX = x
    this.mouseY = y
  }

  update = (dt: number) => {}

  draw = () => {
    love.graphics.push('all')
    this.drawQueue.forEach(([hitbox, drawFn]) => drawFn(this.theme))
    this.drawQueue.clear()
    love.graphics.pop()
  }

  button = (options: UIButton): UIComponentState => {
    const id = options.id || options.text

    this.drawQueue.set(id, [options, drawButton(options)])

    return {
      id,
      isFocused: false,
      isHovered: isHovered(id, this.drawQueue),
      isPressed: false,
      onEnter: false,
      onLeave: false,
    }
  }
}
