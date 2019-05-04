--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
-- Lua Library inline imports
function __TS__InstanceOf(obj, classTbl)
    if obj ~= nil then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

local ____symbolMetatable = {__tostring = function(self)
    if self.description == nil then
        return "Symbol()"
    else
        return "Symbol(" .. tostring(self.description) .. ")"
    end
end}
function __TS__Symbol(self, description)
    return setmetatable({description = description}, ____symbolMetatable)
end
Symbol = {iterator = __TS__Symbol(_G, "Symbol.iterator")}

function __TS__Iterator(iterable)
    local iterator = iterable[Symbol.iterator](iterable)
    return function()
        local result = iterator:next()
        if not result.done then
            return result.value
        else
            return nil
        end
    end
end

Map = {}
Map.name = "Map"
Map.__index = Map
Map.prototype = {}
Map.prototype.__index = Map.prototype
Map.prototype.constructor = Map
function Map.new(...)
    local self = setmetatable({}, Map.prototype)
    self:____constructor(...)
    return self
end
function Map.prototype.____constructor(self, other)
    self.items = {}
    self.size = 0
    if other then
        local iterable = other
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[0 + 1], value[1 + 1])
            end
        else
            local arr = other
            self.size = #arr
            for ____TS_index = 1, #arr do
                local kvp = arr[____TS_index]
                self.items[kvp[0 + 1]] = kvp[1 + 1]
            end
        end
    end
end
function Map.prototype.clear(self)
    self.items = {}
    self.size = 0
    return
end
function Map.prototype.delete(self, key)
    local contains = self:has(key)
    if contains then
        self.size = self.size - 1
    end
    self.items[key] = nil
    return contains
end
Map.prototype[Symbol.iterator] = function(self)
    return self:entries()
end
function Map.prototype.entries(self)
    local items = self.items
    local key
    local value
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            key, value = next(items, key)
            return {
                done = not key,
                value = {
                    key,
                    value,
                },
            }
        end,
    }
end
function Map.prototype.forEach(self, callback)
    for key in pairs(self.items) do
        callback(_G, self.items[key], key, self)
    end
    return
end
function Map.prototype.get(self, key)
    return self.items[key]
end
function Map.prototype.has(self, key)
    return self.items[key] ~= nil
end
function Map.prototype.keys(self)
    local items = self.items
    local key
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            key = next(items, key)
            return {
                done = not key,
                value = key,
            }
        end,
    }
end
function Map.prototype.set(self, key, value)
    if not self:has(key) then
        self.size = self.size + 1
    end
    self.items[key] = value
    return self
end
function Map.prototype.values(self)
    local items = self.items
    local key
    local value
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            key, value = next(items, key)
            return {
                done = not key,
                value = value,
            }
        end,
    }
end

local ____exports = {}
local _cache = Map.new()
local _nextTimerId = 0
____exports.Timer = {}
local Timer = ____exports.Timer
Timer.name = "Timer"
Timer.__index = Timer
Timer.prototype = {}
Timer.prototype.__index = Timer.prototype
Timer.prototype.constructor = Timer
function Timer.new(...)
    local self = setmetatable({}, Timer.prototype)
    self:____constructor(...)
    return self
end
function Timer.prototype.____constructor(self, id, timeout, callback)
    self.id = 0
    self.currentTime = 0
    self.timeout = 0
    self.update = function(____, dt)
        if self.currentTime > self.timeout then
            return false
        end
        self.currentTime = self.currentTime + dt
        if self.currentTime >= self.timeout then
            ____exports.clearTimeout(nil, self.id)
            self:callback()
            return true
        end
        return false
    end
    self.id = id
    self.timeout = timeout
    self.callback = callback
end
____exports.createTimer = function(____, timeout, callback)
    local id = (function()
        local ____TS_tmp = _nextTimerId
        _nextTimerId = ____TS_tmp + 1
        return ____TS_tmp
    end)()
    local timer = ____exports.Timer.new(id, timeout, callback)
    _cache:set(id, timer)
    return timer
end
____exports.setTimeout = function(____, timeout, callback)
    local id = (function()
        local ____TS_tmp = _nextTimerId
        _nextTimerId = ____TS_tmp + 1
        return ____TS_tmp
    end)()
    _cache:set(id, ____exports.Timer.new(id, timeout, callback))
    return id
end
____exports.clearTimeout = function(____, timerId)
    if (type(timerId) == "table" and "object" or type(timerId)) == "number" then
        _cache:delete(timerId)
    end
end
____exports.update = function(____, dt)
    _cache:forEach(function(____, timer)
        if timer:update(dt) then
            ____exports.clearTimeout(nil, timer.id)
        end
    end)
end
return ____exports
