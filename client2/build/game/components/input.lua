--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Input = {}
local Input = ____exports.Input
Input.name = "Input"
Input.__index = Input
Input.prototype = {}
Input.prototype.__index = Input.prototype
Input.prototype.constructor = Input
function Input.new(...)
    local self = setmetatable({}, Input.prototype)
    self:____constructor(...)
    return self
end
function Input.prototype.____constructor(self)
    self._id = ____exports.Input._id
    self._flag = ComponentFlag.Input
end
Input._id = "Input"
Input._flag = ComponentFlag.Input
return ____exports
