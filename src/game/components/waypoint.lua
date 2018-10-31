local constants = require 'game.components.constants'

local Waypoint = {
  _meta = constants.Waypoint
}

function Waypoint.new(id, waypoints)
  return {
    _meta = Waypoint._meta,
    id = id,
    waypoints = waypoints or {},
    current = 1
  }
end

return Waypoint
