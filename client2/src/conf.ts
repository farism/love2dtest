const WINDOW_WIDTH = 800
const WINDOW_HEIGHT = 420

love.conf = (t: Conf) => {
  t.window.title = 'Icepicker'
  t.window.width = WINDOW_WIDTH
  t.window.height = WINDOW_HEIGHT
  t.console = true
}
