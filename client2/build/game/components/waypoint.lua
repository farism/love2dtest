--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_component = require("ecs.component");
local Component = __TSTL_component.Component;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.Waypoint = exports.Waypoint or {};
exports.Waypoint.__index = exports.Waypoint;
exports.Waypoint.prototype = exports.Waypoint.prototype or {};
exports.Waypoint.prototype.__index = exports.Waypoint.prototype;
exports.Waypoint.prototype.constructor = exports.Waypoint;
exports.Waypoint.new = function(...)
    local self = setmetatable({}, exports.Waypoint.prototype);
    self:____constructor(...);
    return self;
end;
exports.Waypoint.prototype.____constructor = function(self, active, speed, path)
    self._id = exports.Waypoint._id;
    self._flag = Flag.Waypoint;
    if active == nil then
        active = true;
    end
    if speed == nil then
        speed = 1;
    end
    self.active = active;
    self.current = 1;
    self.speed = speed;
    self.path = path;
end;
exports.Waypoint._id = "Waypoint";
exports.Waypoint._flag = Flag.Waypoint;
return exports;
