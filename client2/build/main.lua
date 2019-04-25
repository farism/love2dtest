--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local __TSTL_Game = require("game.Game");
local Game = __TSTL_Game.Game;
local game;
love.load = function(arg)
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97);
    love.physics.setMeter(1);
    game = Game.new();
end;
love.update = function(dt)
    if game then
        game:update(dt);
    end
end;
love.draw = function()
    if game then
        game:draw();
    end
end;
