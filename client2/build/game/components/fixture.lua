--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.GameFixture = exports.GameFixture or {};
exports.GameFixture.__index = exports.GameFixture;
exports.GameFixture.prototype = exports.GameFixture.prototype or {};
exports.GameFixture.prototype.__index = exports.GameFixture.prototype;
exports.GameFixture.prototype.constructor = exports.GameFixture;
exports.GameFixture.new = function(...)
    local self = setmetatable({}, exports.GameFixture.prototype);
    self:____constructor(...);
    return self;
end;
exports.GameFixture.prototype.____constructor = function(self, entity, fixture)
    self._id = exports.GameFixture._id;
    self._flag = Flag.GameFixture;
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
exports.GameFixture._id = "GameFixture";
exports.GameFixture._flag = Flag.GameFixture;
return exports;
