-- chops down 2x2 trees, for <length> specified

function fuel()
  if turtle.getFuelLevel() < 10 then
    turtle.select(1)
    if turtle.refuel(1) then
      return true
    end
    print("Refuelling failed.")
    return false
  end
end

function fell()
  local blocksMovedUp = 0
  while turtle.detect() do
    fuel()
    turtle.dig()
    if turtle.detectUp() then
      turtle.digUp()
    end
    turtle.up()
    blocksMovedUp = blocksMovedUp + 1
  end
  while blocksMovedUp > 0 do
    fuel()
    turtle.down()
    blocksMovedUp = blocksMovedUp - 1
  end
end

local tArgs = {...}
if #tArgs ~= 1 or tonumber(tArgs[1]) == nil or math.floor(tonumber(tArgs[1])) ~= tonumber(tArgs[1]) or tonumber(tArgs[1]) < 1 then
  print("Usage: fell <length>")
  return
end

local length = tonumber(tArgs[1])

local blocksMovedForward = 0
while blocksMovedForward < length do
  fell()
  print("Checking to the right of original trunk")
  turtle.turnRight()
  turtle.forward()
  turtle.turnLeft()
  fell()
  print("Checking in front of last trunk")
  turtle.forward()
  fell()
  print("Checking in front of original trunk")
  turtle.forward()
  turtle.turnLeft()
  fell()
  turtle.forward()
  turtle.turnRight()
  blocksMovedForward = blocksMovedForward + 2
end