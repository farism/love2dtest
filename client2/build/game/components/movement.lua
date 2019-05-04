--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Direction = {}
____exports.Direction.Left = "left"
____exports.Direction.left = "Left"
____exports.Direction.Right = "right"
____exports.Direction.right = "Right"
____exports.Movement = {}
local Movement = ____exports.Movement
Movement.name = "Movement"
Movement.__index = Movement
Movement.prototype = {}
Movement.prototype.__index = Movement.prototype
Movement.prototype.constructor = Movement
function Movement.new(...)
    local self = setmetatable({}, Movement.prototype)
    self:____constructor(...)
    return self
end
function Movement.prototype.____constructor(self)
    self._id = ____exports.Movement._id
    self._flag = ComponentFlag.Movement
    self.direction = ____exports.Direction.Right
    self.left = false
    self.right = false
    self.jump = false
    self.jumpCount = 0
end
Movement._id = "Movement"
Movement._flag = ComponentFlag.Movement
return ____exports
