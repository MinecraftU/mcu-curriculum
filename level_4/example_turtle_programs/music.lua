--[[
Program run on a wirless pocket computer
that sends a signal to the music server

Either 'music play sheet' or 'music testmusic'
]]

local tArgs = {...}
rednet.open("back")
rednet.broadcast(tArgs[1], "music")
if tArgs[2] then
  rednet.broadcast(tArgs[2], "music")
end
rednet.close("back")
