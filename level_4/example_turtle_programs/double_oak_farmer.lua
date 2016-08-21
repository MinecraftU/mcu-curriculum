-- tree farmer
-- requires a very specific tree farm setup
--   which I will document somewhere and
--   put a link to when that's done
-- put fuel in first slot
-- put 1 block of wood type in second slot
-- put saplings of wood type in third slot
 
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
  -- plant new tree
  turtle.select(3)
  turtle.place()
  return true
end
 
function detectTree()
  turtle.select(2)
  if turtle.compare() then
    return true
  else
    return false
  end
end
 
function farmTree()
    tries = 0
    while not detectTree() do
      print("Tried " .. tries .. ". No tree. Waiting a minute")
      os.sleep(60)
      tries = tries + 1
    end
    chop()
    right()
    right()
    for i=4,16,1 do
      turtle.select(i)
      turtle.drop()
    end
    right()
    right()
    -- if there are no more saplings
    if turtle.getItemCount(3) == 0 then
      print("Out of samplings")
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

function fif(val, a, b)
  if val then a() else b() end
end

function fif_flip(val, b, b)
  if val then a() else b() end
  return not val
end

fif()

local args = {...}
if #args > 1 or type(args[1]) ~= "string" then
  print("Takes argument: <right/left>")
  return
end

ret = true
left_tree = args[1] == "left"
while ret == true do
  ret = farmTree()
  fif(left_tree, right, left)
  for i=1,10,1 do
    turtle.forward()
  end
  fif(left_tree, left, right)
  left_tree = not left_tree
end


