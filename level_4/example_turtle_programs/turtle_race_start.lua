--[[
Created by atvaccaro, 2014

Used on a wireless pocket computer to signal
the turtle racing master computer to start a race

Uses the 'trp' rednet protocol
]]

rednet.open("back")
rednet.broadcast("start", "trp")
rednet.close("back")
