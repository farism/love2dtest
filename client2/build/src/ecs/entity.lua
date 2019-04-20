--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_component = require("src.ecs.component");
local Component = __TSTL_component.Component;
local __TSTL_manager = require("src.ecs.manager");
local Manager = __TSTL_manager.Manager;
exports.Entity = exports.Entity or {};
exports.Entity.__index = exports.Entity;
exports.Entity.prototype = exports.Entity.prototype or {};
exports.Entity.prototype.__index = exports.Entity.prototype;
exports.Entity.prototype.constructor = exports.Entity;
exports.Entity.new = function(...)
    local self = setmetatable({}, exports.Entity.prototype);
    self:____constructor(...);
    return self;
end;
exports.Entity.prototype.____constructor = function(self, id, manager, meta)
    self.add = function(____, component)
        self.manager:addComponent(self, component);
    end;
    self.as = function(____, component)
        local cmp = self.manager:getComponent(self, component);
        return cmp and (cmp);
    end;
    self.clearFlag = function(____, component)
        if not self:has(component) then
            print(("entity " .. (tostring(self.id) .. " does not have component ")) .. (tostring(component._flag) .. ""));
        end
        self.components = bit.band(self.components, bit.bnot(component._flag));
    end;
    self.destroy = function(____)
        self.manager:removeEntity(self);
    end;
    self.has = function(____, component)
        return bit.band(self.components, component._flag) == component._flag;
    end;
    self.remove = function(____, component)
        self.manager:removeComponent(self, component);
    end;
    self.setFlag = function(____, component)
        if self:has(component) then
            print(("entity " .. (tostring(self.id) .. " already has component ")) .. (tostring(self.id) .. ""));
            return;
        end
        self.components = bit.bxor(self.components, component._flag);
    end;
    self.components = 0;
    self.id = id;
    self.manager = manager;
    self.systems = 0;
end;
return exports;
