--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local exports = exports or {};
local getFlag;
getFlag = function(____, index)
    return bit.lshift(1, index);
end;
exports.Flag = {};
exports.Flag.GameObjectRenderer = getFlag(nil, 0);
exports.Flag[getFlag(nil, 0)] = "GameObjectRenderer";
return exports;
