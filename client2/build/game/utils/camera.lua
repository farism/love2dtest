--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_entity = require("ecs.entity")
local Entity = __TSTL_entity.Entity
____exports.Camera = {}
local Camera = ____exports.Camera
Camera.name = "Camera"
Camera.__index = Camera
Camera.prototype = {}
Camera.prototype.__index = Camera.prototype
Camera.prototype.constructor = Camera
function Camera.new(...)
    local self = setmetatable({}, Camera.prototype)
    self:____constructor(...)
    return self
end
function Camera.prototype.____constructor(self, initialDirection)
    self.clear = function()
        love.graphics.pop()
    end
    self.set = function()
        love.graphics.push()
        love.graphics.translate(math.floor(-self.x + 0.5), math.floor(-self.y + 0.5))
    end
    self.update = function(____, dt, target)
    end
    self.x = 0
    self.y = 0
    self.offset = 0
    self.direction = initialDirection
end
return ____exports
