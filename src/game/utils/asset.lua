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
  return get(_imageCache, love.graphics.newImage, file)
end

function Asset.getSound(file)
  return get(_soundCache, love.audio.newSource, file)
end

function Asset.getMusic(file)
  return get(_musicCache, love.audio.newSource, file)
end

return Asset
