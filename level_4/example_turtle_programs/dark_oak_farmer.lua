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

function fif(val, a, b)
  if val then a() else b() end
end

function fifFlip(val, a, b)
  if val then a() else b() end
  return not val
end

function dig()
  if turtle.detect() then
    turtle.dig()
  end
end

function fell()
  fuel()
  for i=1,10,1 do
    dig()
    turtle.digUp()
    turtle.up()
  end
  
  fuel()
  for i=1,10,1 do
    turtle.down()
  end
end

function fellDarkOak()
  local left = true
  for a=1,4,1 do
    forward()
    fell()
    for b=1,4,1 do
      fif(left, shiftRight, shiftLeft)
      fell()
    end
    left = not left
  end
end

function placeSapling()
  turtle.select(3)
  turtle.placeDown()
end

function dump(start_point,end_point)
  for i=start_point,end_point,1 do
    turtle.select(i)
    turtle.drop()
  end
end

function detectTree()
  turtle.select(2)
  if turtle.compare() then
    return true
  else
    return false
  end
end

function turnAround()
  right()
  right()
end

go = true
while go do
  go = fuel()
  go = turtle.getItemCount(3) > 3
  tree = false
  tries = 0
  while not detectTree() do
    print("Tried " .. tries .. ". No tree. Waiting a minute")
    os.sleep(60)
    tries = tries + 1
  end
  turnAround()
  forward()
  forward()
  turnAround()
  -- farm that tree
  shiftLeft()
  fellDarkOak()
  right()
  turtle.up()
  forward()
  placeSapling()
  forward()
  placeSapling()
  right()
  forward()
  placeSapling()
  right()
  forward()
  placeSapling()
  forward()
  left()
  turtle.down()
  for i=1,5,1 do
    forward()
  end
  dump(4,16)
  left()
  forward()
  left()
  for i=1,4,1 do
    forward()
  end
end