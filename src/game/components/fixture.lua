local constants = require 'game.components.constants'

local Fixture = {
  _meta = constants.Fixture
}

function Fixture.new(id, entity, fixture)
  local data = fixture:getUserData() or {}
  data.entity = entity
  data.type = entity.meta.type
  fixture:setUserData(data)

  return {
    _meta = Fixture._meta,
    id = id,
    entity = entity,
    fixture = fixture
  }
end

return Fixture
