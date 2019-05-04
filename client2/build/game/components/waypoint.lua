--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Waypoint = {}
local Waypoint = ____exports.Waypoint
Waypoint.name = "Waypoint"
Waypoint.__index = Waypoint
Waypoint.prototype = {}
Waypoint.prototype.__index = Waypoint.prototype
Waypoint.prototype.constructor = Waypoint
function Waypoint.new(...)
    local self = setmetatable({}, Waypoint.prototype)
    self:____constructor(...)
    return self
end
function Waypoint.prototype.____constructor(self, active, speed, path)
    self._id = ____exports.Waypoint._id
    self._flag = ComponentFlag.Waypoint
    if active == nil then
        active = true
    end
    if speed == nil then
        speed = 1
    end
    self.active = active
    self.current = 0
    self.speed = speed
    self.path = path
end
Waypoint._id = "Waypoint"
Waypoint._flag = ComponentFlag.Waypoint
return ____exports
