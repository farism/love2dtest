local IntervalSystem = require 'src.ecs.intervalsystem'

local function update(entities)
  -- print('logger update ', entities)
end

local Logger = IntervalSystem:new('logger', nil, 1, update)

return Logger
