# Section 2: Cobblestone Miner

So far all we've done is run commands that are already built into the turtles and computers. Starting in this section, we'll write some of our own programs, to make the turtle do whatever we want it to.

Let's start off with a simple program, one that will make sure you never run out of cobblestone again. If you've used a cobblestone generator before, this is similar to that, except that it's a turtle doing the harvesting, not you.

First build a cobblestone generator. If you mine out that cobblestone, more will replace it after it breaks. Now we need to place our turtle so it can mine the cobblestone for us. Place your turtle facing the cobblestone, and put a chest behind it. Make sure you use a `mining turtle`, and to make your code easier to write, use an `advanced mining turtle`.

<img src="images/section_2/cobblefarm1.png" style="width:50%">

Now we need to set our turtle's label, so that if we ever break him, he'll keep the programs we write. Type `label set cobblefarmer` and press `enter`:
<img src="images/section_2/cobblefarm2.png" style="width:50%">

Congrats! You've done all the actual block placing you need to. Now we can start writing code. Type `edit cobblefarm` and press `enter`. This will open the editing program and let you start writing your own code:
<img src="images/section_2/cobblefarm3.png" style="width:50%">

The editor program looks like this:
<img src="images/section_2/cobblefarm4.png" style="width:50%">

Since you typed `edit cobblefarm`, your program will be called `cobblefarm` when you save it. To open the `Save/Run/Exit` menu, press `control` or `ctrl` on your keyboard. The text in the corner that says `Ln 1` is the line counter. When you write code, it's split up into lines, just like regular writing. Whenever there's an error in your code, it will tell you which line the error is on, and that's when this line counter is really useful.

Let's start writing some code! Start off by copying down the code written below. This is called a while loop. The `while` command checks if something is true or false and then keeps running the code if the thing is true. The `do` part is what tells the computer that you're done defining the loop and you want it to start running code. At the end of every loop you write, you have to have the code `end`. This tells the program to end the looped section of code.

Since we wrote `while true do`, the code will run forever, because the statement `true`, by itself, will always be `true` and not `false`.

```lua
while true do

end
```

<img src="images/section_2/cobblefarm5.png" style="width:50%">

Next we'll fill in our loop with some code. All we need for this program is two commands. Copy down the code as shown below. The command `turtle.dig()` tells the turtle to mine the block in front of it. Once it mines the block, it will have it in it's inventory. The second command is to put the cobblestone into a chest, and it looks like we made a mistake! There are command for `turtle.drop()`, `turtle.dropUp()`, and `turtle.dropDown()`, but nothing for `turtle.dropBack()`. Instead we'll just use `turtle.dropUp()` for now.

<img src="images/section_2/cobblefarm6.png" style="width:50%">

Once you've written you two lines of code, press `control` or `ctrl` on your keyboard to open the menu, and then press `enter` to save your program. Now press `control` again, press the `right arrow key` to move to `exit`, and then press `enter` to close the editor program.

Type `cobblefarm` and press `enter`. This will start your program! If you press `escape`, you'll see that your turtle is gathering cobblestone for you.

Now to put the cobble in the chest, you need to turn the turtle around and use the `drop` command to place the cobble in the chest. Modify your program to this:

```lua
while true do
  turtle.dig()
  turtle.turnLeft()
  turtle.turnLeft()
  turtle.drop()
  turtle.turnLeft()
  turtle.turnLeft()
end
```

*Do not forget to save!*

<img src="images/section_2/cobblefarm7.png" style="width:50%">

Once the chest is full, you can open your turtle again and hold down `control` and `t` at the same time to terminate your program.

**Congratulations!** You just wrote your first simple program in ComputerCraft. In the next few sections, we'll write more useful programs, and more complex ones.
