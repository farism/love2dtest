--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Container = {}
local Container = ____exports.Container
Container.name = "Container"
Container.__index = Container
Container.prototype = {}
Container.prototype.__index = Container.prototype
Container.prototype.constructor = Container
function Container.new(...)
    local self = setmetatable({}, Container.prototype)
    self:____constructor(...)
    return self
end
function Container.prototype.____constructor(self)
    self._id = ____exports.Container._id
    self._flag = ComponentFlag.Container
end
Container._id = "Container"
Container._flag = ComponentFlag.Container
return ____exports
