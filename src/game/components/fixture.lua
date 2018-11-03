local constants = require 'game.components.constants'

local Fixture = {
  _meta = constants.Fixture
}

function Fixture.new(id, entity, fixture)
  local instance = {
    _meta = Fixture._meta,
    id = id,
    entity = entity,
    fixture = fixture
  }

  local data = fixture:getUserData() or {}
  data.entity = entity
  fixture:setUserData(data)

  function instance:destroy()
    self.fixture:getBody():destroy()
  end

  return instance
end

return Fixture
