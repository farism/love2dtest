--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local __TSTL_manager = require("ecs.manager");
local Manager = __TSTL_manager.Manager;
local __TSTL_camera = require("game.utils.camera");
local Camera = __TSTL_camera.Camera;
local __TSTL_State = require("game.State");
local State = __TSTL_State.State;
exports.Game = exports.Game or {};
exports.Game.__index = exports.Game;
exports.Game.prototype = exports.Game.prototype or {};
exports.Game.prototype.__index = exports.Game.prototype;
exports.Game.prototype.constructor = exports.Game;
exports.Game.new = function(...)
    local self = setmetatable({}, exports.Game.prototype);
    self:____constructor(...);
    return self;
end;
exports.Game.prototype.____constructor = function(self)
    self.setState = function(____, state)
        self.state = state;
    end;
    self.restart = function(____)
    end;
    self.keyboard = function(____, key, scancode, isRepeat, isPressed)
        self.manager:keyboard(key, scancode, isRepeat, isPressed);
    end;
    self.mouse = function(____, x, y, isTouch, presses)
        self.manager:mouse(x, y, isTouch, presses);
    end;
    self.update = function(____, dt)
        self.manager:update(dt);
        if self.state == State.PLAYING then
            self.world:update(dt);
            self.manager:update(dt);
        end
    end;
    self.draw = function(____)
        self.camera:set();
        self.manager:draw();
        self.camera:clear();
    end;
    self.state = State.PAUSED;
    self.world = love.physics.newWorld(0, 9.81, true);
    self.world:setCallbacks(function(a, b, contact)
        self.manager:beginContact(a, b, contact);
    end, function(a, b, contact)
        self.manager:endContact(a, b, contact);
    end);
    self.manager = Manager.new(self.world);
    self.camera = Camera.new("right");
    love.physics.setMeter(256);
end;
return exports;
