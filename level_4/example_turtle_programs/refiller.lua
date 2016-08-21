function fuel()
  if turtle.getFuelLevel() < 30 then
    turtle.select(1)
    if turtle.refuel(1) then
      return true
    end
    print("Refuelling failed.")
    return false
  end
end

function right()
  turtle.turnRight()
end

function left()
  turtle.turnLeft()
end

function forward()
  turtle.forward()
end

function shiftRight()
  right()
  forward()
  left()
end

function shiftLeft()
  left()
  forward()
  right()
end

function dig()
  if turtle.detect() then
    turtle.dig()
  end
end

function dump(start_point,end_point)
  for i=start_point,end_point,1 do
    turtle.select(i)
    turtle.drop()
  end
end

function turnAround()
  right()
  right()
end

function fif(val, a, b)
  if val then a() else b() end
end

function fifFlip(val, a, b)
  if val then a() else b() end
  return not val
end

local function tryPlaceDown()
  -- keeping slot a global for now
  if turtle.getItemCount(slot) == 0 then
    slot = slot + 1
  end

  if slot < 17 then
    turtle.select(slot)
    if turtle.detectDown() then
      turtle.digDown()
    end
    turtle.placeDown()
    return true
  else
    print("No more material")
    return false
  end
end

local function tryForward()
  fuel()
  if tryPlaceDown() then
    dig()
    forward()
    return true
  else 
    return false
  end
end

--
--
local tArgs = {...}
if tArgs[1] == "help" then
  print("Usage: refiller <length> <width> <height>")
  return
end
if tonumber(tArgs[1]) ~= nil then
  y = math.floor(tonumber(tArgs[1]))
end
if tonumber(tArgs[2]) ~= nil then
  x = math.floor(tonumber(tArgs[2]))
end
if tonumber(tArgs[3]) ~= nil then
  height = math.floor(tonumber(tArgs[3]))
end
if not y then
  y = 10
end
if not x then
  x = 10
end
if not height then
  height = 10
end
print(x, y, height)
slot = 2
height = 5
success = true
last = false
turn_right = true
while height > 0 and success do
  -- the floor placement
  for i = 1, x do
    for j = 1, y - 1 do
      success = tryForward()
    end
    fif(turn_right, right, left)
    dig()
    tryForward()
    turn_right = fifFlip(turn_right, right, left)
  end
  turn_right = not turn_right
  turn_right = fif(turn_right, right, left)
  dig()
  forward()
  turn_right = fifFlip(turn_right, right, left)
  turtle.digUp()
  turtle.up()
  height = height - 1
end
