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

function chop ()
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
  return true
end

function goNext()
  fuel()
  i = 1
  print(i)
  while i < 5 do
    print(i)
    turtle.forward()
    i = i + 1
  end
  turtle.turnLeft()
  -- has the tree grown?
  ret = false
  while ret == false do
    ret = detectTree()
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

function farmSide()
  tree = 0
  while tree < 2 do
    treeFarm()
    turtle.turnRight()
    tree = tree + 1
  end
  turtle.turnRight()
end

function treeFarm()
  goNext()
  chop()
end

side = 0
while side < 3 do
  farmSide
  side = side + 1
end
treeFarm()
turtle.turnRight()
