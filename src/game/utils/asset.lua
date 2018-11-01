local Asset = {}

local _imageCache = {}
local _soundCache = {}
local _musicCache = {}

local function get(cache, loader, file)
  if (cache[file]) then
    return cache[file]
  else
    local asset = loader(file)
    cache[file] = asset

    return asset
  end
end

function Asset.getImage(file)
  local image = get(_imageCache, love.graphics.newImage, file)
  image:setWrap('repeat', 'repeat')

  return image
end

function Asset.getSound(file)
  local sound = get(_soundCache, love.audio.newSource, file)

  return sound
end

function Asset.getMusic(file)
  local music = get(_musicCache, love.audio.newSource, file)

  return music
end

return Asset
