--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
love.load = function(arg)
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97);
    love.physics.setMeter(1);
end;
love.update = function(delta)
    if love.keyboard.isDown("e") then
    end
end;
love.draw = function()
    love.graphics.print("hello world!!!", 400, 300);
end;
