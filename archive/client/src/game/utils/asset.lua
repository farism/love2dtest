local json = require 'src.vendor.json'

local Asset = {}

local _levelCache = {}
local _imageCache = {}
local _soundCache = {}

function Asset.getLevel(file)
  if _levelCache[file] then
    return _levelCache[file]
  else
    local result = love.filesystem.newFile(file):read()
    local level = json.decode(result)
    _levelCache[file] = level
  end

  return _levelCache[file]
end

function Asset.getImage(file)
  if _imageCache[file] then
    return _imageCache[file]
  else
    local image = love.graphics.newImage(file)
    image:setWrap('repeat', 'repeat')
    _imageCache[file] = image
  end

  return _imageCache[file]
end

function Asset.getSound(file)
  if _soundCache[file] then
    return _soundCache[file]
  else
    local sound = love.audio.newSource(file)
    _soundCache[file] = sound
  end

  return _soundCache[file]
end

return Asset
