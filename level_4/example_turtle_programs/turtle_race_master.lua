--[[
Created by atvaccaro, 2014

Master server for starting turtle races

Uses the 'trp' rednet protocol
]]

function start()
  rs.setOutput("back", true)
  sleep(1)
  rs.setOutput("back", false)
end

rednet.open("top")
while true do
  local id, message, prot = rednet.receive("trp")
  if message == "start" then
    start()
  end
end
