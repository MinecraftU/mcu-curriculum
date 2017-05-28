# Section 5: The Room

Let's write a program to build a simple room: `edit room`

Step one is to check your arguments to make sure they are what you need them to be.

For that we use the code `local tArgs = {...}`, which loads the arguments into your program.

```lua
local tArgs = {...}

if #tArgs ~= 3 then
  print ("Usage: room <l> <w> <h>")
  return false
end
for i=1,3 do
  if tonumber(tArgs[i]) < 1 then
    print("Usage: room <l> <w> <h>")
    return false
  end
end
```

This block of code takes arguments and checks to make sure there are 3 of them, and that all are numbers greater than 1.
If they aren't, it prints a line that tells the user how to run the program.

Now, we take the three arguments and assign them to the correct variables.

```lua
length = tArgs[1]
width = tArgs[2]
height = tArgs[3]
```

And we refuel the turtle.

```lua
turtle.select(1)
turtle.refuel()

if turtle.getFuelLevel() < 150 then
  print("Fuel level too low.")
  return false
end
```

Here, we select the first slot, and load the turtle with fuel from that slot.

This program is going to have a few functions as well. This is our first function. It searches for items starting in slot 2, the slot right after the fuel slot. Note that it doesn't check to make sure they are placable items, and will not stop you from trying to build a house made of carrots.

```lua
function findItems()
  local slot = 2
  while slot < 16 do
    if turtle.getItemCount(slot) < 1  then
      slot = slot + 1
    else
      turtle.select(slot)
      return true
    end
  end
  return false
end
```

This function builds one single row of blocks, using a for loop to stop it when it reaches the desired length.

```lua
function buildRow(rowLen)
  for i = 1, rowLen, 1 do
    findItems()
    turtle.placeDown()
    turtle.forward()
  end
end
```

This function calls the `buildRow()` function using the variables we set earlier, to make a whole layer of the house. Note that it turns right every time. This means that you must start the house at the bottom left corner.

```lua
function buildLayer()
  turtle.up()
  buildRow(length)
  turtle.turnRight()
  buildRow(width)
  turtle.turnRight()
  buildRow(length)
  turtle.turnRight()
  buildRow(width)
  turtle.turnRight()
end
```

Now that we have useful functions to call, we can write the part of the program that does things!

```lua
for i=1, height, 1 do
  buildLayer()
end
```

All this does is call buildLayer() for the number of layers you specified with `height`

**And we're done!** Feed your turtle coal and a building material and run the program with `room <length> <width> <height>`

Now you're finished with the main parts of Level 4! Hopefully you have a good idea of how to write your own programs in the future. If you have any questions feel free to ask us, and remember, *the wiki is your friend*: [http://www.computercraft.info/wiki/Main_Page](http://www.computercraft.info/wiki/Main_Page)

For additional ComputerCraft exercises, check out the appendices!
