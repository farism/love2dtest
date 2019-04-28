--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_flags = require("game.flags");
local ComponentFlag = __TSTL_flags.ComponentFlag;
exports.GameObject = exports.GameObject or {};
exports.GameObject.__index = exports.GameObject;
exports.GameObject.prototype = exports.GameObject.prototype or {};
exports.GameObject.prototype.__index = exports.GameObject.prototype;
exports.GameObject.prototype.constructor = exports.GameObject;
exports.GameObject.new = function(...)
    local self = setmetatable({}, exports.GameObject.prototype);
    self:____constructor(...);
    return self;
end;
exports.GameObject.prototype.____constructor = function(self, entity, fixture)
    self._id = exports.GameObject._id;
    self._flag = ComponentFlag.GameObject;
    self.destroy = function(____)
        self.fixture:getBody():destroy();
    end;
    self.entity = entity;
    self.fixture = fixture;
    local data = fixture:getUserData() or {};
    data.entity = self.entity;
    fixture:setUserData(data);
    fixture:getBody():setUserData(data);
end;
exports.GameObject._id = "GameObject";
exports.GameObject._flag = ComponentFlag.GameObject;
return exports;
