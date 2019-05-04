--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Checkpoint = {}
local Checkpoint = ____exports.Checkpoint
Checkpoint.name = "Checkpoint"
Checkpoint.__index = Checkpoint
Checkpoint.prototype = {}
Checkpoint.prototype.__index = Checkpoint.prototype
Checkpoint.prototype.constructor = Checkpoint
function Checkpoint.new(...)
    local self = setmetatable({}, Checkpoint.prototype)
    self:____constructor(...)
    return self
end
function Checkpoint.prototype.____constructor(self, index, visited)
    self._id = ____exports.Checkpoint._id
    self._flag = ComponentFlag.Checkpoint
    if index == nil then
        index = 1
    end
    if visited == nil then
        visited = false
    end
    self.index = index
    self.visited = visited
end
Checkpoint._id = "Checkpoint"
Checkpoint._flag = ComponentFlag.Checkpoint
return ____exports
