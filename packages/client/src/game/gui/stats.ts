export const draw = () => {
  love.graphics.printf(
    `FPS: ${tostring(love.timer.getFPS())}`,
    0,
    50,
    love.graphics.getWidth() - 20,
    'right'
  )
}
