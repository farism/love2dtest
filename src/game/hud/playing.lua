local Playing = {}

function Playing.update(dt, suit)
  if suit.Button('Resume', (800 - 300) / 2, 100, 300, 30).hit then
  end

  if suit.Button('Restart', (800 - 300) / 2, 160, 300, 30).hit then
  end

  if suit.Button('Settings', (800 - 300) / 2, 220, 300, 30).hit then
  end

  if suit.Button('Main Menu', (800 - 300) / 2, 280, 300, 30).hit then
  end
end

return Playing
