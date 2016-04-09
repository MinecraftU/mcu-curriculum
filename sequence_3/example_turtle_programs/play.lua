--[[
Loads a file using dofile() and broadcasts to
the note block server computers
]]

local tArgs = {...}
local file = dofile(tArgs[1]) --loads the sheet music file
print("Playing "..tArgs[1])
file.build()
for i=1,#sheet,2 do
  rednet.broadcast(tostring(sheet[i]), "music")
  sleep(sheet[i+1]/4.0*0.25)  --+ 0.1)
