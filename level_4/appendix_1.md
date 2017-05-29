## Turtle Program Boilerplate

This section contains some turtle code that can make writing new turtle programs easier. It contains what are called _helper functions_ to handle certain things (like refueling) and make other things shorter to write (like turning around).

You can `pastebin` this code from [https://pastebin.com/7r6V30wi](https://pastebin.com/7r6V30wi).

```lua
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
  return turtle.forward()
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

function shiftNRight(n)
  right()
  for i=1,n,1 do
    forward()
  end
  left()
end

function shiftNLeft(n)
  left()
  for i=1,n,1 do
    forward()
  end
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

function move(len)
  for i=1,len,1 do
    fuel()
    while not forward() do
      if not turtle.dig() then
        turtle.attack()
      end
    end
  end
end
```
