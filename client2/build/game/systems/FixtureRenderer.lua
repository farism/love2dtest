--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_System = require("ecs.System");
local System = __TSTL_System.System;
local __TSTL_fixture = require("game.components.fixture");
local GameFixture = __TSTL_fixture.GameFixture;
local __TSTL_flags = require("game.systems.flags");
local Flag = __TSTL_flags.Flag;
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
    self._id = exports.FixtureRenderer._id;
    self._flag = exports.FixtureRenderer._flag;
    self.draw = function(____)
        self.entities:forEach(function(____, entity)
            local fixture = entity:as(GameFixture);
        end);
    end;
end;
exports.FixtureRenderer._id = "FixtureRenderer";
exports.FixtureRenderer._flag = Flag.FixtureRenderer;
return exports;
