--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
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

local exports = exports or {};
local imageCache = Map.new();
local audioCache = Map.new();
exports.loadImage = function(____, filepath)
    if imageCache:get(filepath) then
        return imageCache:get(filepath);
    else
        local image = love.graphics.newImage(filepath);
        image:setWrap("repeat", "repeat");
        imageCache:set(filepath, image);
        return image;
    end
end;
exports.loadAudio = function(____, filepath)
    if audioCache:get(filepath) then
        return audioCache:get(filepath);
    else
        local audio = love.audio.newSource(filepath, "static");
        audioCache:set(filepath, audio);
        return audio;
    end
end;
return exports;
