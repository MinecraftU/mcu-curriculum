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

function fif(val, a, b)
  if val then a() else b() end
end

function fif_flip(val, b, b)
  if val then a() else b() end
  return not val
end

function farmRow()
  forward()
  turtle.digDown()
  turtle.suck()
  
end