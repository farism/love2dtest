--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
____exports.isShapeType = function(____, type, shape) return shape:getType() == type end
____exports.isPolygonShape = function(____, shape)
    return ____exports.isShapeType(nil, "polygon", shape)
end
____exports.isCircleShape = function(____, shape)
    return ____exports.isShapeType(nil, "circle", shape)
end
____exports.isChainShape = function(____, shape)
    return ____exports.isShapeType(nil, "chain", shape)
end
____exports.isEdgeShape = function(____, shape)
    return ____exports.isShapeType(nil, "edge", shape)
end
return ____exports
