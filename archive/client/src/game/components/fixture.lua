local constants = require 'src.game.components.constants'

local Fixture = {
  _meta = constants.Fixture
}

function Fixture.new(id, entity, fixture, category, mask, group)
  local instance = {
    _meta = Fixture._meta,
    id = id,
    entity = entity,
    fixture = fixture
  }

  -- set the entity to the fixture as userData
  local data = fixture:getUserData() or {}
  data.entity = entity
  fixture:setUserData(data)
  fixture:getBody():setUserData(data)

  function instance:destroy()
    self.fixture:getBody():destroy()
  end

  return instance
end

return Fixture
