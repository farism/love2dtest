--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Position = {}
local Position = ____exports.Position
Position.name = "Position"
Position.__index = Position
Position.prototype = {}
Position.prototype.__index = Position.prototype
Position.prototype.constructor = Position
function Position.new(...)
    local self = setmetatable({}, Position.prototype)
    self:____constructor(...)
    return self
end
function Position.prototype.____constructor(self, x, y)
    self._id = ____exports.Position._id
    self._flag = ComponentFlag.Position
    if x == nil then
        x = 0
    end
    if y == nil then
        y = 0
    end
    self.x = x
    self.y = y
end
Position._id = "Position"
Position._flag = ComponentFlag.Position
return ____exports
