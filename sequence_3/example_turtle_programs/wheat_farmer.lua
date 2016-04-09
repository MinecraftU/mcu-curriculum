--[[
Created by atvaccaro, 2015

Configurable wheat farmer intended for rectangular or square fields

Syntax is wheat_farmer <length> <width>

Turtle should start on the "bottom-right" corner of the wheat farm AT GROUND LEVEL

A chest behind him is for seeds, and a chest to the right is for wheat

So the starting config is:
XXXXXXXX
XXXXXXXX
     STW

X = farmland, S = seed chest, T = turtle, W = wheat chest

He must be refueled manually at the moment
--]]
local fuelSlot = 1
local seedSlot = 2
local wheatSlot = 4

local tArgs = {...}

function farm(length, width)
  for i=1,width do
    farmColumn(length)
    if width%2==0 then --right turn
      right()
    else
      left()
    end
  end
end

function farmColumn(length)
  for i=1,length do
    turtle.forward()
    turtle.digDown()
    turtle.suckDown()
    turtle.select(seedSlot)
    if turtle.getItemCount() then
      turtle.select(seedSlot+1)
    end
    turtle.placeDown()
end

function right()
  turtle.turnRight()
  turtle.forward()
  turtle.turnRight()
  turtle.back()
end

function left()
  turtle.turnLeft()
  turtle.forward()
  turtle.turnLeft()
  turtle.back()
end

function refuel()
  turtle.select(fuelSlot)
  turtle.refuel(1)
end

--Drop off extra seeds and refill slots seedSlot and seedSlot+1
function dropAndRefillSeeds()
  turtle.turnLeft()

  --drop seeds
  for i=wheatSlot,16 do
    turtle.select(i)
    if turtle.getItemDetail().name == "minecraft:seeds" then
      turtle.drop()
    end
  end

  --refill seeds
  turtle.select(seedSlot)
  turtle.suck()
  turtle.select(seedSlot+1)
  turtle.suck()
  turtle.turnRight()
end

function dropWheat()
  turtle.turnRight()
  for i=wheatSlot,16 do
    turtle.select(i)
    if turtle.getItemDetail().name == "minecraft:wheat" then
      turtle.drop()
    end
  end
  turtle.turnLeft()
end
