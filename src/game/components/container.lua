local constants = require 'game.components.constants'

local Container = {
  _meta = constants.Container
}

function Container.new(id)
  return {
    _meta = Container._meta,
    id = id
  }
end

return Container
