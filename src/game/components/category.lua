local constants = require 'game.components.constants'

local Category = {
  _meta = constants.Category
}

function Category.new(id, categories)
  local category = {
    _meta = Category._meta,
    id = id
  }

  for key, value in ipairs(categories) do
    category[key] = value
  end

  return category
end

return Category
