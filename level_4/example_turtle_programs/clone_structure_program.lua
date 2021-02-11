local blocks = {}
local rows = {}
local tArgs = {...}
local length = tArgs[1]
local width = tArgs[2]
local height = tArgs[3]

if #tArgs < 3 or #tArgs > 5 then
    print("Usage: clone (length) (width) (height) (X/Z offset) (Y offset)")
    error("X/Z offset and Y default to 0. Y can be negative or positive. X/Z direction depends on starting orientation")
end

function scan(i)
    if turtle.detect() then
        local success, data = turtle.inspect()
        table.insert(blocks, data.name)
        print("inserted " .. blocks[i])
    else
        print("inserted air")
        table.insert(blocks, "air")
    end
end

-- find specified item in inventory and select that slot
function selItem(item)
    local done = false
    turtle.select(1)
    for slot = 1, 16 do
        if done then
            done = false
            return true
        end
        if turtle.getItemCount(slot) > 0 then
            slotData = turtle.getItemDetail(slot)
            if slotData.name == item then
                turtle.select(slot)
                print("attempting to select" .. item)
                done = true
            end
        end
    end
end

--inspect, log, and dig each block of one row
function scanRow()
    for i = 1, length do
        scan(i)
        turtle.dig()
        turtle.forward()
    end
end

--scanRow() and then reverse to replace each block of one row according to the saved list
function copyRow()
    scanRow()
    turtle.back()
    placeRow()
    turtle.forward()
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
    table.insert(rows, blocks)
    blocks = {}
end

-- place a row of blocks according to a saved list
function placeRow()
    for i = length, 1, -1 do
        if blocks[i] == "air" then
            print("leaving air gap")
            turtle.back()
        else
            selItem(blocks[i])
            sleep(0.1)
            print("placing" .. blocks[i])
            turtle.place()
            turtle.back()
        end
    end
end

-- paste in each row of current plane
function pasteArea()
    for i = 1, width do
        for i = 1, length do
            turtle.forward()
        end
        blocks = rows[i]
        placeRow()
        turtle.turnRight()
        turtle.forward()
        turtle.turnLeft()
    end
end

--setup offset to pasteArea() based on user input
if #tArgs < 4 then
    dist = 0
elseif #tArgs == 4 then
    dist = tArgs[4]
elseif #tArgs == 5 then
    dist = tArgs[4]
    distY = tArgs[5]
end

-- same idea here but for the distances to go back after each pasteArea()
if #tArgs < 4 then
    distBack = (width * 2)
elseif #tArgs == 4 then
    distBack = (dist + width)
elseif #tArgs == 5 then
    distBack = (dist + width * 2)
    distBackY = tonumber(tArgs[5])
end

-- main loop to copyArea, move to paste location, pasteArea, move back to copyArea on next y level
for i = 1, height do
    -- copy each row of one plane
    for i = 1, width do
        copyRow()
    end
    -- move to target Y pos for pasting a new plane
    if #tArgs == 5 then
        if tonumber(distY) > 0 then
            for i = 1, math.abs(distY) do
                turtle.up()
            end
        elseif tonumber(distY) < 0 then
            for i = 1, math.abs(distY) do
                turtle.down()
            end
        end
 
        if distBackY > 0 then
            for i = 1, distBackY do
                turtle.down()
            end
        elseif distBackY < 0 then
            for i = 1, math.abs(distBackY) do
                turtle.up()
            end
        end
    end
    
    -- move using given offset or deafault to paste X/Z
    turtle.turnRight()
    if dist > 0 then
        for i = 1, dist do
            turtle.forward()
        end
    end
    turtle.turnLeft()
    turtle.back()
    pasteArea()
    
    -- move to beginning of next plane to copy
    turtle.turnLeft()
    for i = 1, distBack do
        turtle.forward()
    end
    turtle.turnRight()
    turtle.forward()
    turtle.up()
    
    -- reset list of rows and list of blocks
    rows = {}
    blocks = {}
end

-- move back to original start height
for i = 1, height do
    turtle.down()
end
