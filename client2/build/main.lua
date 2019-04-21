--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local __TSTL_Game = require("game.Game");
local Game = __TSTL_Game.Game;
local game = Game.new();
love.load = function(arg)
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97);
    love.physics.setMeter(1);
end;
love.update = function(delta)
end;
love.draw = function()
    love.graphics.print("hello world!!!", 400, 300);
end;
