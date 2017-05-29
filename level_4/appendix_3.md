## Food farming

This program will continuously farm any square food farm.

![](images/appendix_3/farm-setup.png)

You can `pastebin` this code from `RgMwfx6y`.

Fuel goes in the first slot, seeds (or other plantable item) in the second.

```lua
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

function right()
  turtle.turnRight()
end

function left()
  turtle.turnLeft()
end

function forward()
  turtle.forward()
end

function digDown()
  turtle.digDown()
end

function suckDown()
  turtle.suckDown()
end

function fif(val, a, b)
  if val then a() else b() end
end

function fif_flip(val, a, b)
  if val then a() else b() end
  return not val
end

function farm_row(len)
  for i=1,len,1 do
    fuel()
    forward()
    digDown()
    turtle.select(3)
    suckDown()
    turtle.select(2)
    turtle.placeDown()
  end
end

function farm(len)
  local turn_right = true
  for i=1,len,1 do
    farm_row(len)
    forward()
    fif(turn_right, right, left)
    forward()
    turn_right = fif_flip(turn_right, right, left)
  end
  left()
  for i=1,len,1 do
    forward()
  end
  for i=3,16,1 do
    turtle.select(i)
    turtle.drop()
  end
  right()
end

while true do
  -- enter the dimensions of your farm here
  farm(8)
  -- increase this number if your crops are not growing fast enough
  os.sleep(2400)
end
```
