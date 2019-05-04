--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local __TSTL_Entity = require("ecs.Entity")
local Entity = __TSTL_Entity.Entity
local __TSTL_flags = require("game.flags")
local ComponentFlag = __TSTL_flags.ComponentFlag
____exports.GameObject = {}
local GameObject = ____exports.GameObject
GameObject.name = "GameObject"
GameObject.__index = GameObject
GameObject.prototype = {}
GameObject.prototype.__index = GameObject.prototype
GameObject.prototype.constructor = GameObject
function GameObject.new(...)
    local self = setmetatable({}, GameObject.prototype)
    self:____constructor(...)
    return self
end
function GameObject.prototype.____constructor(self, entity, fixture)
    self._id = ____exports.GameObject._id
    self._flag = ComponentFlag.GameObject
    self.destroy = function()
        self.fixture:getBody():destroy()
    end
    self.entity = entity
    self.fixture = fixture
    local data = fixture:getUserData() or {}
    data.entity = self.entity
    fixture:setUserData(data)
    fixture:getBody():setUserData(data)
end
GameObject._id = "GameObject"
GameObject._flag = ComponentFlag.GameObject
return ____exports
