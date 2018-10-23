local function sleep(s)
  local ntime = os.clock() + s
  repeat
  until os.clock() > ntime
end

return sleep
