--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_flags = require("game.components.flags");
local Flag = __TSTL_flags.Flag;
exports.EntityFixture = exports.EntityFixture or {};
exports.EntityFixture.__index = exports.EntityFixture;
exports.EntityFixture.prototype = exports.EntityFixture.prototype or {};
exports.EntityFixture.prototype.__index = exports.EntityFixture.prototype;
exports.EntityFixture.prototype.constructor = exports.EntityFixture;
exports.EntityFixture.____super = Component;
setmetatable(exports.EntityFixture, exports.EntityFixture.____super);
setmetatable(exports.EntityFixture.prototype, exports.EntityFixture.____super.prototype);
exports.EntityFixture.new = function(...)
    local self = setmetatable({}, exports.EntityFixture.prototype);
    self:____constructor(...);
    return self;
end;
exports.EntityFixture.prototype.____constructor = function(self, entity, fixture)
    self._id = exports.EntityFixture._id;
    self._flag = Flag.EntityFixture;
    self.destroy = function(____)
        self.fixture:getBody():destroy();
    end;
    Component.prototype.____constructor(self);
    self.entity = entity;
    self.fixture = fixture;
    local data = fixture:getUserData() or {};
    data.entity = self.entity;
    fixture:setUserData(data);
    fixture:getBody():setUserData(data);
end;
exports.EntityFixture._id = "EntityFixture";
exports.EntityFixture._flag = Flag.EntityFixture;
return exports;
