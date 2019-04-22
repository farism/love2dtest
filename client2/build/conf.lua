--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
exports.WINDOW_WIDTH = 800;
exports.WINDOW_HEIGHT = 420;
love.conf = function(t)
    t.window.title = "Icepicker";
    t.window.width = exports.WINDOW_WIDTH;
    t.window.height = exports.WINDOW_HEIGHT;
    t.console = true;
end;
return exports;
