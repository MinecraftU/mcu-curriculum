-- fuel in slot 1
-- stairs in slot 2

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

function dig()
  if turtle.detect() then
   turtle.dig()
  end
end

function digDown()
  if turtle.detectDown() then
    turtle.digDown()
  end
end

function stairMe()
  digDown()
  turtle.select(2)
  turtle.placeDown()
end

function moveMe()
  dig()
  turtle.forward()
  turtle.down()
end



floors = 15

stairMe()



sides = floors * 4
sidesCompleted = 0
while sides > sidesCompleted do
  fuel()
  moveMe()
  stairMe()
  moveMe()
  stairMe()
  turtle.turnRight()
end