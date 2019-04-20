local constants = require 'src.game.components.constants'

local Waypoint = {
  _meta = constants.Waypoint
}

function Waypoint.new(id, speed, waypoints)
  return {
    _meta = Waypoint._meta,
    id = id,
    active = true,
    current = 1,
    speed = speed or 1,
    waypoints = waypoints or {}
  }
end

return Waypoint
