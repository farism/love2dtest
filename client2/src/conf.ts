require('lib/inspect')

export const WINDOW_WIDTH = 800
export const WINDOW_HEIGHT = 420

love.conf = (t: Conf) => {
  t.window.title = 'Icepicker'
  t.window.width = WINDOW_WIDTH
  t.window.height = WINDOW_HEIGHT
  t.window.highdpi = true
  // t.window.borderless = true
  t.console = true
}
