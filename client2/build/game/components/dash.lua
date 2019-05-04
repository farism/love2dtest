--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Dash = {}
local Dash = ____exports.Dash
Dash.name = "Dash"
Dash.__index = Dash
Dash.prototype = {}
Dash.prototype.__index = Dash.prototype
Dash.prototype.constructor = Dash
function Dash.new(...)
    local self = setmetatable({}, Dash.prototype)
    self:____constructor(...)
    return self
end
function Dash.prototype.____constructor(self, velocity)
    self._id = ____exports.Dash._id
    self._flag = ComponentFlag.Dash
    if velocity == nil then
        velocity = 0
    end
    self.velocity = velocity
end
Dash._id = "Dash"
Dash._flag = ComponentFlag.Dash
return ____exports
