--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
__TS__ArrayForEach = function(arr, callbackFn)
    do
        local i = 0;
        while i < (#arr) do
            callbackFn(_G, arr[i + 1], i, arr);
            i = i + 1;
        end
    end
end;

local exports = exports or {};
local __TSTL_conf = require("conf");
local WINDOW_WIDTH = __TSTL_conf.WINDOW_WIDTH;
local WINDOW_HEIGHT = __TSTL_conf.WINDOW_HEIGHT;
local __TSTL_Entity = require("ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_Component = require("ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_gameobject = require("game.components.gameobject");
local GameObject = __TSTL_gameobject.GameObject;
local BlueprintType = {};
BlueprintType.Ground = "ground";
BlueprintType.ground = "Ground";
exports.Factory = exports.Factory or {};
exports.Factory.__index = exports.Factory;
exports.Factory.prototype = exports.Factory.prototype or {};
exports.Factory.prototype.__index = exports.Factory.prototype;
exports.Factory.prototype.constructor = exports.Factory;
exports.Factory.new = function(...)
    local self = setmetatable({}, exports.Factory.prototype);
    self:____constructor(...);
    return self;
end;
exports.Factory.prototype.____constructor = function(self, manager)
    self.attach = function(____, ____TS_bindingPattern0)
        local entity = ____TS_bindingPattern0.entity;
        local components = ____TS_bindingPattern0.components;
        __TS__ArrayForEach(components, function(____, component)
            return self.manager:addComponent(entity, component);
        end);
    end;
    self.ground = function(____)
        local entity = self.manager:createEntity();
        entity.userData.blueprint = BlueprintType.Ground;
        local body = love.physics.newBody(self.manager.world, WINDOW_WIDTH / 2, WINDOW_HEIGHT - 15, "static");
        local shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30);
        local fixture = love.physics.newFixture(body, shape, 1);
        return {entity = entity, components = {GameObject.new(entity, fixture)}};
    end;
    self.draw = function(____)
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()));
    end;
    self.manager = manager;
    self.entity = self.manager:createEntity();
    self.body = love.physics.newBody(self.manager.world, WINDOW_WIDTH / 2, WINDOW_HEIGHT - 15, "static");
    self.shape = love.physics.newRectangleShape(WINDOW_WIDTH * 10, 30);
    self.fixture = love.physics.newFixture(self.body, self.shape, 1);
end;
return exports;
