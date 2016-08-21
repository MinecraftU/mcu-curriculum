function fuel()
  if turtle.getFuelLevel() < 20 then
    turtle.select(1)
    if turtle.refuel(1) then
      return true
    end
    print("Refuelling failed.")
    return false
  end
  return true
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

function fif(val, a, b)
  if val then a() else b() end
end

function detect()
  return turtle.detect()
end

local args = {...}
if #args > 1 or type(args[1]) ~= "string" then
  print("Takes argument: <right/left>")
  return
end

left_side = args[1] == "left"
while fuel() do
  print("refueled")
  tries = 0
  while not detect() do
    print("Tried " .. tries .. ". No tree. Waiting a minute")
    os.sleep(60)
    tries = tries + 1
  end
  print("Found cane")
  for i=1,8,1 do
    turtle.dig()
    forward()
  end
  right()
  right()
  for i=1,8,1 do
    turtle.suckDown()
    forward()
  end
  fif(left_side, left, right)
  forward()
  forward()
  fif(left_side, left, right)
  left_side = not left_side
end