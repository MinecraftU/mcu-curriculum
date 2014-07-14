# Section 4: Advanced ComputerCraft

## Tunneling

This program will require a mining turtle (a turtle with a diamond pickaxe equipped).

The "tunnel" program has the turtle dig a tunnel that is two (2) blocks high, three (3) blocks wide and  _distance_ blocks long (the turtle will stop mining when its inventory is full, it runs out of fuel, or it hits bedrock).  It has the following format:

```tunnel <distance>```

Try typing `tunnel 5`

Note that the turtle will automatically pick up what it mines and it fills in gaps in the floor.

WARNING: It will not block water or LAVA flow.

## Excavate

The "excavate" program makes the turtle dig a hole that is _distance_ x _distance_ until it hits bedrock.

It uses the format: `excavate <distance>`

Try typing  `excavate 5` but don't let it dig too deep!

Notice that the Turtle digs _distance_ blocks forward and then _distance_ blocks to the right.  Keep this in mind in case there's something important in close proximity.

Like the tunnel program, the turtle will stop when its inventory is full, it runs out of fuel, or it hits bedrock.

Tip: Try putting a chest directly behind the turtle before you start the excavation program.

## Writing a simple turtle program (with arguments!)

### Communication between computers/turtles

As I'm sure you've realized, programming on a turtle can be a little tedious, especially with longer, more complex programs. For convenience, people have developed better environments for programming know as IDE's (Integrated Development Environment). In Minecraft, we have a luaIDE on the "computer" and we can transfer programs we write on the computer to turtles using "floppy disks."

1. Create a rough version of the program.
    1. Right click the turtle to boot it up.
    1. Type `label set mover` where _mover_ is the "name" of the turtle.
        1. This will make the programs on this turtle stick around when you break it and place it somewhere else.
    1. For easier editing, run the luaide program.
    1. Create a new program called "move"
        1. Inside the file you just created, try writing a program to make the turtle move forward.
        1. If you need help you can look in a couple places:
            1. There is a complete list of every command you can give a turtle [here on the ComputerCraft wiki.](http://computercraft.info/wiki/index.php?title=Turtle_(API))
            1. There is also a program called `go` that is located at `\programs\go` on your turtle.
                1. Press `Ctrl+O` to open files in LuaIDE.
            1. Looking at this program and the wiki will help you understand how the turtle commands work.

1. Basics of LUA  
    A standard block of code in lua looks like this.
    ```lua
    turtle.refuel()
    while turtle.detectDown() do
      turtle.dig()
      turtle.digDown()
      turtle.down()
      turtle.dig()
      turtle.forward()
      turtle.turnLeft()
    end
    ```

## Cobble Harvesting

Remember the cobblestone generator? What if we could make a turtle automatically harvest that cobblestone? Let's do it!

First, underneath the row of cobblestone, put a mining turtle.

![What you should see.](images/section_4/Placement.png)

Since we'll be writing a program, let's name the turtle so we don't lose it.  

`label set SoMuchCobble`

Let's start coding!  

`edit cobbling`  

This will create a new program called "cobbling" that will be stored on the turtle's internal memory. Program names **are case-sensitive.**

Now let's consider the problem.  What do we want the turtle to do **exactly**?  Let's break it down.

1. Detect if there is a block above it  
1. If there is a block above it, mine it  
1. Otherwise, wait for a block to appear above it.  
1. repeat

Breaking problems down into simple steps is a large part of a programmer's job.  Computers themselves are not smart...yet.
So now we have a general outline for the program, but it's in English. Computers don't speak English. Let's translate it!  

1. `turtle.detectUp()`  
1. `if turtle.detectUp()` then `turtle.digUp()`  
1. `else sleep(1)`  
1. loop

Explanation: 

`turtle.detectUp()` is a function that has the turtle check if there is a block directly above it.  
`turtle.digUp()` is a function that makes the turtle dig or mine the block above it.  
`sleep(1)` is a function that makes the turtle wait for one (1) second.  

For this program, we'll be using a `while` loop.

For detailed descriptions check out the [turtle API](http://computercraft.info/wiki/Turtle_(API)).

So our program will look like this:

```lua
while turtle.getItemCount(16) < 64 do  
  if turtle.detectUp() then  
  turtle.digUp()  
  sleep(1)  
  else sleep(1)  
  end  
end  
```

It should look like this:

![What you should see.](images/section_4/sample.png)

Program Walkthrough:  

1. `while turtle.getItemCount(16) < 64 do` Creates what's known as a "while" loop. This has the turtle do whatever the program says as long as the condition `turtle.getItemCount(16) < 64` is "true".
1. `turtle.getItemCount(16) < 64` Checks if the number items in the last inventory slot of the turtle is less than 64. Basically it checks to make sure the turtle isn't out of inventory space and returns a "true" or "false".
1. `if turtle.detectUp() then` has the turtle check if there is a block above it and if it's "true" it continues with the `then` statement. If there is not a block above it, the check will return "false" and the turtle will skip to the `else` part of the program.
1. `turtle.digUp() sleep(1)` has the turtle break the block above it and then wait for one (1) second for the cobble generator to create another block.
1. `else sleep(1)` Only happens if step 3 returned "false" in which case the turtle waits one (1) second for the cobble generator to create another block.
1. The two end statements simply close the loops.

## Room building

Let's write a program to build a simple square room: `luaide room`

Step one is to check your arguments to make sure they are what you need them to be.

```lua
local tArgs = {...}

if #tArgs ~= 3 then
  print ("Usage: room <l> <w> <h>")
end
for i=1,3 do
  if tonumber(tArgs[i]) < 1 then
    print("Usage: room <l> <w> <h>")
  end
end
```

This block of code takes arguments and checks to make sure there are 3 of them, and that all are numbers greater than 1.
If they aren't, it prints a line that tells the user how to run the program.

Now, we take the three arguments and assign them to the correct variables.

```lua
length = tonumber(tArgs[1])
width = tonumber(tArgs[2])
height = tonumber(tArgs[3])
```

And we refuel the turtle.

```lua
turtle.select(1)
turtle.refuel()

if turtle.getFuelLevel() < 50 then
  print("Fuel level too low.")
  return false
end
```

Here, we select the first slot, and load the turtle with fuel from that slot.

This program is going to be in a few different sections, or functions.

```lua
function buildRow(rowLen)
  for i = 1, rowLen do
    findItems()
    turtle.placeDown()
    turtle.forward()
  end
end
```
This first function builds one single row of blocks, using a for loop to stop it when it reaches the desired length.

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

This function calls the `buildRow()` function using the variables we set earlier, to make a whole layer of the house. Note that it turns right every time. This means that you must start the house at the bottom left corner.

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

This is our final function. It searches for items starting in slot 2, the slot right after the fuel slot. Note that it doesn't check to make sure they are placable items, and will not stop you from trying to build a house made of carrots.

Now that we have useful functions to call, we can write the part of the program that does things!

```lua
for i=1,height do
  buildLayer()
end
```

All this does is call buildLayer() for the number of layers you specified with `height`

And we're done! Feed your turtle coal and a building material and run the program with `room <length> <width> <height>`

## Mining

Another useful program! You can point this one at a wall and it will dig a two block tall and one block wide tunnel. It will also place torches every 8 blocks.

We'll also build this one with several different functions.
The first will check if the turtle is on solid ground, and if not, it will place a block below itself.

```lua
function placeFloorBlock()
  if not turtle.detectDown() then
    turtle.select(3)
    if turtle.placeDown() then
      return true
    end
    print("Placing Floor Failed")
    return false
  end
end
```

This next function is a basic check for fuel, and if it sees that the turtle is low on fuel, it will try to refuel from inventory slot 1.

```lua
function fuel()
  if turtle.getFuelLevel() < 10 then
    turtle.select(1)
    if turtle.refuel(1) then
      return true
    end
    print("Refuelling Failed")
    return false
  end
end
```

You can see that this function returns true if the refueling was successful, and false if not.

Our next function digs our tunnel. The basic idea of this while and if loop is that if the turtle is not moving forward, it will dig, and if it can't dig, it attacks. It also detects blocks above it and digs those as well.

```lua
function DigAndMove()
  while not turtle.forward() do
    if not turtle.dig() then
      turtle.attack()
    end
  end
  while turtle.detectUp() do
    turtle.digUp()
    sleep(0.5)
  end
  placeFloorBlock()
end
```

This function turns the turtle around. Should be obvious.

```lua
function turnAround()
  turtle.turnLeft()
  turtle.turnLeft()
end
```

This is a function that turns the turtle to the right, digs out a block, checks make sure that the block didn't get filled in, and then places a torch in the space. If it fails to place a torch, it returns false, otherwise it returns true.

```lua
function placeTorch()
  turtle.turnRight()
  turtle.dig()
  if not turtle.detect() then
    turtle.select(2)
    if turtle.place() then
      turtle.turnLeft()
      return true
    end
  end
  print("Place Torch Failed")
  turtle.turnLeft()
  return false
end
```

Again, this is a piece of code that accepts and checks arguments to make sure they work with the program.

```lua
local tArgs = {...}
if #tArgs ~= 1 or tonumber(tArgs[1]) == nil or math.floor(tonumber(tArgs[1])) ~= tonumber(tArgs[1]) or tonumber(tArgs[1]) < 1 then
  print("Usage: tunnel+ <length>")
  return
end
```

Here we set two variables, one for the length you give as an argument, and one to use in the `moveBack` section of code.

```lua
local length = tonumber(tArgs[1])
local moveBack = 0
```

Now we put it all together.

* First we fuel the turtle by calling `fuel()`.
* Then we call `DigAndMove()` to move the turtle forward one tunnel section.
* We increment the `blocksMovedForward` variable to keep track of where we are.
* Next we check if the block we are on is a multiple of 8.
* If it is, we call the `placeTorch()` function.
* At the end, we turn the turtle around and retrace our steps back to the start of the tunnel.

```lua
local blocksMovedForward = 0
while blocksMovedForward < length do
  fuel()
  DigAndMove()
  blocksMovedForward = blocksMovedForward + 1
  
  -- Add torch every 8 blocks
  if (blocksMovedForward % 8) == 0 then
    placeTorch()
  end
  
  if blocksMovedForward == length then
    turnAround()
    while moveBack < length do
      turtle.forward()
      sleep(1)
      print("Taking step: ")
      print(moveBack)
      moveBack = moveBack + 1
    end
  end
end
```
