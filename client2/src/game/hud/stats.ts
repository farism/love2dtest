export const draw = () => {
  love.graphics.printf(
    `FPS: ${tostring(love.timer.getFPS())}`,
    0,
    20,
    love.graphics.getWidth() - 20,
    'right'
  )
}
