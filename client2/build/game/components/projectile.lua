--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.Projectile = {}
local Projectile = ____exports.Projectile
Projectile.name = "Projectile"
Projectile.__index = Projectile
Projectile.prototype = {}
Projectile.prototype.__index = Projectile.prototype
Projectile.prototype.constructor = Projectile
function Projectile.new(...)
    local self = setmetatable({}, Projectile.prototype)
    self:____constructor(...)
    return self
end
function Projectile.prototype.____constructor(self)
    self._id = ____exports.Projectile._id
    self._flag = ComponentFlag.Projectile
end
Projectile._id = "Projectile"
Projectile._flag = ComponentFlag.Projectile
return ____exports
