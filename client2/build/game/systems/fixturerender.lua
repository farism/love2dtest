--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_fixture = require("game.components.fixture");
local EntityFixture = __TSTL_fixture.EntityFixture;
exports.FixtureRenderer = exports.FixtureRenderer or {};
exports.FixtureRenderer.__index = exports.FixtureRenderer;
exports.FixtureRenderer.prototype = exports.FixtureRenderer.prototype or {};
exports.FixtureRenderer.prototype.__index = exports.FixtureRenderer.prototype;
exports.FixtureRenderer.prototype.constructor = exports.FixtureRenderer;
exports.FixtureRenderer.____super = System;
setmetatable(exports.FixtureRenderer, exports.FixtureRenderer.____super);
setmetatable(exports.FixtureRenderer.prototype, exports.FixtureRenderer.____super.prototype);
exports.FixtureRenderer.new = function(...)
    local self = setmetatable({}, exports.FixtureRenderer.prototype);
    self:____constructor(...);
    return self;
end;
exports.FixtureRenderer.prototype.____constructor = function(self, ...)
    System.prototype.____constructor(self, ...);
    self.draw = function(____)
        self.entities:forEach(function(____, entity)
            local fixture = entity:as(EntityFixture);
            print(fixture);
        end);
    end;
end;
return exports;
