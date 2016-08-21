--[[
Created by atvaccaro, 2015

Configurable tree farmer intended for spruce or birch (since they grow straight)

Setup (from the back):
 F
STW

F = furnace
S = sapling chest
T = turtle
W = wood chest

Setup (from the top):

 X  X  X  X
 X  X  X  X

STW

Number of rows, number of columns, and spaces between columns are defined with arguments
]]

tArgs = {...}
rows = tonumber(tArgs[1])
columns = tonumber(tArgs[2])
spaces = tonumber(tArgs[3])
