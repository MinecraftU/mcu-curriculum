-- Tower builder by Eli Delventhal aka demonpants, v 0.6
-- modded by dealingwith

local tArgs = { ... }
if #tArgs < 2
then
  print( "Usage: tower <#diameter> <#height> [round|square] [#roofHeight] [#roofDiameter] [crenellation|saddleback|apex|flat]" )
  return
end

-- If our diameter is too small, kick out

local diameter = tonumber( tArgs[1] )
local radius = diameter / 2
if radius < 1
then
  print( "Tower diameter must be positive" )
  return
end

-- If our height is too small, kick out

local height = tonumber( tArgs[2] )
if height < 1
then
  print( "Tower height must be positive" )
  return
end

-- check optional parameters

local towerType = "round"
if #tArgs >= 3
then
  towerType = tArgs[3]
  if towerType ~= "round" and towerType ~= "square"
  then
    print("Tower type must be round or square "..towerType)
    return
  end
end

local roofHeight = 0
if #tArgs >= 4
then
  roofHeight = tonumber( tArgs[4] )
end

local roofDiameter = 0
if #tArgs >= 5
then
  roofDiameter = tonumber( tArgs[5] )
end

local roofType = "crenellation"
if roofHeight > 0 and #tArgs >= 6
then
  roofType = tArgs[6]
  if roofType ~= "crenellation" and roofType ~= "saddleback" and roofType ~= "apex" and roofType ~= "flat"
  then
    print("Tower roof type myst be crenellation, saddleback, or apex")
    return
  end
end

-- we need to store off our position and which way we're 
-- facing so that we can move along our way correctly

local centerX = math.floor(radius)
local centerZ = centerX
local startDirX = 0
local startDirZ = 1
local xPos = centerX
local yPos = 0
local zPos = centerZ
local xDir = startDirX
local zDir = startDirZ
local placedBlockCount = 0
local xPoints = {}
local xPointsLength = 0
local zPoints = {}
local zPointsLength = 0

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

-- Builds below the current position if that spot is free.
-- If a block is already there and it's not the same type as what's
-- in our active slot, the block is dug and a new one is placed
-- If we have no blocks left, returns false, otherwise returns true.

local function build()

  local itemSlot = -1
  local freeSlot = -1
  
  -- store off the first empty slot and the first slot we can pull an item from
  for n=2,16
  do
    if turtle.getItemCount(n) > 0
    then
      if itemSlot < 0
      then
        itemSlot = n
      end
    elseif freeSlot < 0
      then 
      freeSlot = n
    end
  end
  
  -- we have items in any slot, go ahead and build
  if itemSlot >= 0
  then
    -- this block is not the same type as what we have, dig it out
    if turtle.detectDown() and not turtle.compareDown()
    then
      turtle.digDown()
      -- if we had a free slot and now have only 1 item in it, throw that out
      if freeSlot >= 0 and turtle.getItemCount(freeSlot) == 1
      then
        turtle.select(freeSlot)
        turtle.drop(1)
      end
    end
    -- we know we have an empty spot, place the block
    turtle.select(itemSlot)
    turtle.placeDown()
    placedBlockCount = placedBlockCount + 1
    return true
  end
  
  -- no items in any slots, we can't build
  return false
end

-- sorts the movement coordinates so that the turtle is moving optimally

local function sortMovementCoordinates()
  
  -- first find the one closest to the turtle and put that in front
  --[[ local closest = 0
  local closestDist = math.abs( xPoints[closest] - xPos ) + math.abs( zPoints[closest] - zPos )
  for i = 1, xPointsLength - 1
  do
    local dist = math.abs( xPoints[i] - xPos ) + math.abs( zPoints[i] - zPos )
    if dist < closestDist
    then
      closest = i
      closestDist = dist
    end
  end
  local swap = xPoints[0]
  xPoints[0] = xPoints[closest]
  xPoints[closest] = swap
  swap = zPoints[0]
  zPoints[0] = zPoints[closest]
  zPoints[closest] = swap ]]
  
  -- next sort all points to be the one closest to the previous point
  for i = 0, xPointsLength - 2
  do
    closest = i + 1
    closestDist = math.abs( xPoints[closest] - xPoints[i] ) + math.abs( zPoints[closest] - zPoints[i] )
    
    for j = i + 2, xPointsLength - 1
    do
      local dist = math.abs( xPoints[j] - xPoints[i] ) + math.abs( zPoints[j] - zPoints[i] )
      if dist < closestDist
      then
        closest = j
        closestDist = dist
      end
    end
    swap = xPoints[i+1]
    xPoints[i+1] = xPoints[closest]
    xPoints[closest] = swap
    swap = zPoints[i+1]
    zPoints[i+1] = zPoints[closest]
    zPoints[closest] = swap
  end
end

-- populates the two lists of movement coordinates with X and Y coordinates for a round tower

local function populateMovementCoordinatesRound()
  xPoints = {}
  xPointsLength = 0
  zPoints = {}
  zPointsLength = 0
  local d = 3 - (2 * radius)
  local x = 0
  local z = math.floor(radius);
  
  -- use the midpoint circle algorithm to construct a list of exactly which points we need
  repeat
    xPoints[xPointsLength] = centerX + x;
    zPoints[zPointsLength] = centerZ + z;
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    xPoints[xPointsLength] = centerX + x;
    zPoints[zPointsLength] = centerZ - z;
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    xPoints[xPointsLength] = centerX - x;
    zPoints[zPointsLength] = centerZ + z;
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    xPoints[xPointsLength] = centerX - x;
    zPoints[zPointsLength] = centerZ - z;
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    xPoints[xPointsLength] = centerX + z;
    zPoints[zPointsLength] = centerZ + x;
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    xPoints[xPointsLength] = centerX + z;
    zPoints[zPointsLength] = centerZ - x;
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    xPoints[xPointsLength] = centerX - z;
    zPoints[zPointsLength] = centerZ + x;
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    xPoints[xPointsLength] = centerX - z;
    zPoints[zPointsLength] = centerZ - x;
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    if d < 0
    then
      d = d + (4 * x) + 6
    else
      d = d + 4 * (x - z) + 10
      z = z - 1
    end
    
    x = x + 1
  until x > z
end

-- populates the two lists of movement coordinates with X and Y coordinates for a square tower

local function populateMovementCoordinatesSquare()
  xPoints = {}
  xPointsLength = 0
  zPoints = {}
  zPointsLength = 0
  
  local left = math.floor( diameter / 2)
  local right = math.ceil( diameter / 2)
  
  for i = 0, diameter - 1
  do
    xPoints[xPointsLength] = 0
    zPoints[zPointsLength] = i
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    xPoints[xPointsLength] = diameter - 1
    zPoints[zPointsLength] = i
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
    
    xPoints[xPointsLength] = i
    zPoints[zPointsLength] = 0
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1

    xPoints[xPointsLength] = i
    zPoints[zPointsLength] = diameter - 1
    xPointsLength = xPointsLength + 1
    zPointsLength = zPointsLength + 1
  end 
end

-- populates the two lists of movement coordinates with X and Y coordinates for crenellations

local function populateMovementCoordinatesRoofCrenellations()
  
end

-- the turtle will turn towards the passed direction
-- returns true if he is facing that way, false if he needs to keep turning

local function turnTo( x, z )
  
  --       0,1
  -- -1,0      1,0
  --      0,-1
  
  -- early out in case we're already facing that way
  if xDir == x and zDir == z
  then
    return true
  end
  
  -- facing up or down
  if xDir == 0
  then
    -- want to face right
    if x == 1
    then
      if zDir == -1
      then
        turtle.turnLeft()
      else
        turtle.turnRight()
      end
      xDir = 1
      zDir = 0
    -- want to face left
    else
      if zDir == -1
      then
        turtle.turnRight()
      else
        turtle.turnLeft()
      end
      xDir = -1
      zDir = 0
    end
  -- facing left or right
  else
    -- want to face up
    if z == 1
    then
      if xDir == -1
      then
        turtle.turnRight()
      else
        turtle.turnLeft()
      end
      xDir = 0
      zDir = 1
    -- want to face down
    else
      if xDir == -1
      then
        turtle.turnLeft()
      else
        turtle.turnRight()
      end
      xDir = 0
      zDir = -1
    end
  end
  
  -- if we're now facing that way, return true
  if xDir == x and zDir == z
  then
    return true
  end
  
  return false
  
end

-- the turtle will attempt to move to the passed location
-- returns true if he got there or was blocked, false if he needs to keep moving

local function moveTo( x, z )
    
  -- early out in case we're already there
  if xPos == x and zPos == z
  then
    return true
  end
  fuel()
  -- first move along x, then along z
  if xPos ~= x
  then
    if xPos > x
    then
      if turnTo(-1,0)
      then
        if turtle.forward()
        then
          xPos = xPos - 1
        end
      end
    else
      if turnTo(1,0)
      then
        if turtle.forward()
        then
          xPos = xPos + 1
        end
      end
    end
  elseif zPos ~= z
  then
    if zPos > z
    then
      if turnTo(0,-1)
      then
        if turtle.forward()
        then
          zPos = zPos - 1
        end
      end
    else
      if turnTo(0,1)
      then
        if turtle.forward()
        then
          zPos = zPos + 1
        end
      end
    end
  end
    
  if xPos == x and zPos == z
  then
    return true
  end
  
  return false
  
end

-- //////////////////////////// start of real program ///////////////////////////// --

-- populate the list of points of where we need to go

if towerType == "round"
then
  populateMovementCoordinatesRound()
else
  populateMovementCoordinatesSquare()
end

sortMovementCoordinates()

-- loop through our height until we finish, run out of blocks, or get stuck

local success = true
for yPos = 0, height - 1
do
  -- we will be building below for easy unobstructed movement
  turtle.up()
  yPos = yPos + 1
    
  -- move to all the points
  for i = 0, xPointsLength - 1
  do
    -- keep trying to move to the nearest point
    local tries = 0
    
    while not moveTo(xPoints[i], zPoints[i])
    do
      tries = tries + 1
      if tries > diameter * 2
      then
        print( "Failed to reach destination, giving up." )
        success = false
        break
      end
    end
    
    if not success
    then
      break
    end
    
    -- we are at the next point, build
    if not build()
    then
      print( "Ran out of blocks, stopping.")
      success = false
      break
    end
  end
  
  if not success
  then
    break
  end
  
  -- we finished this floor successfully, yay
  
end

-- we have built the entire tower, now build the roof

if success and roofHeight > 0
then
  print("Walls completed. Building roof.")
  
  
end

-- move back to the center

local tries = 0
while not moveTo(centerX, centerZ) or not turnTo(startDirX, startDirZ)
do
  tries = tries + 1
  if tries > diameter * 2
  then
    break
  end
end

if success
then
  print("Tower completed.")
else
  turtle.down() -- go down so we can try again
end