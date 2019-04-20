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

__TS__InstanceOf = function(obj, classTbl)
    if obj ~= nil then
        local luaClass = obj.constructor;
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true;
            end
            luaClass = luaClass.____super;
        end
    end
    return false;
end;

local ____symbolMetatable = {__tostring = function(self)
    if self.description == nil then
        return "Symbol()";
    else
        return ("Symbol(" .. self.description) .. ")";
    end
end};
__TS__Symbol = function(self, description)
    return setmetatable({description = description}, ____symbolMetatable);
end;
Symbol = {iterator = __TS__Symbol(_G, "Symbol.iterator")};

__TS__Iterator = function(iterable)
    local iterator = iterable[Symbol.iterator](iterable);
    return function()
        local result = iterator:next();
        if not result.done then
            return result.value;
        else
            return nil;
        end
    end;
end;

Map = Map or {};
Map.__index = Map;
Map.prototype = Map.prototype or {};
Map.prototype.__index = Map.prototype;
Map.prototype.constructor = Map;
Map.new = function(...)
    local self = setmetatable({}, Map.prototype);
    self:____constructor(...);
    return self;
end;
Map.prototype.____constructor = function(self, other)
    self.items = {};
    self.size = 0;
    if other then
        local iterable = other;
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable);
            while true do
                local result = iterator:next();
                if result.done then
                    break;
                end
                local value = result.value;
                self:set(value[0 + 1], value[1 + 1]);
            end
        else
            local arr = other;
            self.size = #arr;
            for ____TS_index = 1, #arr do
                local kvp = arr[____TS_index];
                self.items[kvp[0 + 1]] = kvp[1 + 1];
            end
        end
    end
end;
Map.prototype.clear = function(self)
    self.items = {};
    self.size = 0;
    return;
end;
Map.prototype.delete = function(self, key)
    local contains = self:has(key);
    if contains then
        self.size = self.size - 1;
    end
    self.items[key] = nil;
    return contains;
end;
Map.prototype[Symbol.iterator] = function(self)
    return self:entries();
end;
Map.prototype.entries = function(self)
    local items = self.items;
    local key;
    local value;
    return {[Symbol.iterator] = function(self)
        return self;
    end, next = function(self)
        key, value = next(items, key);
        return {done = not key, value = {key, value}};
    end};
end;
Map.prototype.forEach = function(self, callback)
    for key in pairs(self.items) do
        callback(_G, self.items[key], key, self);
    end
    return;
end;
Map.prototype.get = function(self, key)
    return self.items[key];
end;
Map.prototype.has = function(self, key)
    return self.items[key] ~= nil;
end;
Map.prototype.keys = function(self)
    local items = self.items;
    local key;
    return {[Symbol.iterator] = function(self)
        return self;
    end, next = function(self)
        key = next(items, key);
        return {done = not key, value = key};
    end};
end;
Map.prototype.set = function(self, key, value)
    if not self:has(key) then
        self.size = self.size + 1;
    end
    self.items[key] = value;
    return self;
end;
Map.prototype.values = function(self)
    local items = self.items;
    local key;
    local value;
    return {[Symbol.iterator] = function(self)
        return self;
    end, next = function(self)
        key, value = next(items, key);
        return {done = not key, value = value};
    end};
end;

__TS__ArrayPush = function(arr, ...)
    local items = ({...});
    for ____TS_index = 1, #items do
        local item = items[____TS_index];
        arr[(#arr) + 1] = item;
    end
    return #arr;
end;

__TS__ArrayFilter = function(arr, callbackfn)
    local result = {};
    do
        local i = 0;
        while i < (#arr) do
            if callbackfn(_G, arr[i + 1], i, arr) then
                result[(#result) + 1] = arr[i + 1];
            end
            i = i + 1;
        end
    end
    return result;
end;

local exports = exports or {};
local __TSTL_Component = require("src.ecs.Component");
local Component = __TSTL_Component.Component;
local __TSTL_Entity = require("src.ecs.Entity");
local Entity = __TSTL_Entity.Entity;
local __TSTL_System = require("src.ecs.System");
local System = __TSTL_System.System;
exports.Manager = exports.Manager or {};
exports.Manager.__index = exports.Manager;
exports.Manager.prototype = exports.Manager.prototype or {};
exports.Manager.prototype.__index = exports.Manager.prototype;
exports.Manager.prototype.constructor = exports.Manager;
exports.Manager.new = function(...)
    local self = setmetatable({}, exports.Manager.prototype);
    self:____constructor(...);
    return self;
end;
exports.Manager.prototype.____constructor = function(self, world)
    self.getFactory = function(____)
        return self.factory;
    end;
    self.setFactory = function(____, factory)
        self.factory = factory;
    end;
    self.getNextid = function(____)
        return (function()
            local ____TS_tmp = self.nextId;
            self.nextId = ____TS_tmp + 1;
            return ____TS_tmp;
        end)();
    end;
    self.newEntity = function(____, id)
        local entity = Entity.new(id or self:getNextid(), self);
        return entity;
    end;
    self.getEntity = function(____, id)
        return self.entities:get(id);
    end;
    self.addEntity = function(____, entity)
        self:check(entity);
        self.entities:set(entity.id, entity);
    end;
    self.removeEntity = function(____, entity)
        __TS__ArrayForEach(self.systems, function(____, sys)
            return sys:remove(entity);
        end);
        self:removeComponents(entity);
        self.components:delete(entity.id);
        self.entities:delete(entity.id);
    end;
    self.getComponent = function(____, entity, component)
        local components = self.components:get(entity.id);
        return components and components:get(component._flag);
    end;
    self.setComponent = function(____, entity, component, value)
        local components = self.components:get(entity.id) or Map.new();
        components:set(component._flag, value);
        self.components:set(entity.id, components);
    end;
    self.addComponent = function(____, entity, component)
        entity:setFlag(component);
        self:setComponent(entity, component, component);
        self:check(entity);
    end;
    self.removeComponent = function(____, entity, component)
        entity:clearFlag(component);
        self:setComponent(entity, component, nil);
        self:check(entity);
    end;
    self.removeComponents = function(____, entity)
    end;
    self.addSytem = function(____, system)
        self.entities:forEach(function(____, entity)
            return system:check(entity);
        end);
        system:setManager(self);
        __TS__ArrayPush(self.systems, system);
    end;
    self.removeSystem = function(____, system)
        self.systems = __TS__ArrayFilter(self.systems, function(____, s)
            return s.id ~= system.id;
        end);
    end;
    self.check = function(____, entity)
        __TS__ArrayForEach(self.systems, function(____, system)
            return system:check(entity);
        end);
    end;
    self.keyboard = function(____, key, scancode, isRepeat, isPressed)
        __TS__ArrayForEach(self.systems, function(____, s)
            return s:keyboard(key, scancode, isRepeat, isPressed);
        end);
    end;
    self.mouse = function(____, x, y, isTouch, presses)
        __TS__ArrayForEach(self.systems, function(____, s)
            return s:mouse(x, y, isTouch, presses);
        end);
    end;
    self.beginContact = function(____, a, b, contact)
        __TS__ArrayForEach(self.systems, function(____, s)
            return s:beginContact(a, b, contact);
        end);
    end;
    self.endContact = function(____, a, b, contact)
        __TS__ArrayForEach(self.systems, function(____, s)
            return s:endContact(a, b, contact);
        end);
    end;
    self.update = function(____, dt)
        __TS__ArrayForEach(self.systems, function(____, s)
            return s:update(dt);
        end);
    end;
    self.draw = function(____)
        __TS__ArrayForEach(self.systems, function(____, s)
            return s:draw();
        end);
    end;
    self.components = Map.new();
    self.entities = Map.new();
    self.nextId = 0;
    self.systems = {};
    self.world = world;
end;
return exports;
