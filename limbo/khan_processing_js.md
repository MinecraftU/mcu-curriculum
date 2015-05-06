# Section 3: Khan Academy ProcessingJS

Now we're going to learn some basic programming concepts using ProcessingJS and Khan Academy. If you haven't heard of Khan Academy, it is a website that has instructional videos for math, history, and many other subjects. Last year, they introduced a programming platform that's based around shapes, colors, and animation.

1. Open up khanacademy.org and click on the "Learn" tab at the top left. Then hover over the "Computing" tab and click on "Computer Programming". On the next page, click "Create Program" over on the left side of the screen.
1. This is the IDE (or Integrated Development Environment) for Khan Academy's programming tutorials. Code that is typed into the left box will be executed real-time in the right box; any changes you make will immediately be reflected on the right side.  
![The Khan Academy IDE.](images/section_3/academy_workspace.PNG)
1. If you scroll down the page, you'll see the references section. This has a listing of many of the ProcessingJS commands and their uses. Double-clicking on a command will bring up an example in a new window, so you can understand how each command works if you're ever confused.

## Drawings

To start off, we're going to make some simple printing and drawing as visuals help teach coding principles before we move onto turtles. Each line of code that we type is called a _statement_ and each statement must end in a semicolon.

1. To print text to the screen, call the `text(text, x, y)` function. Be sure to put your text in double quotation marks; characters inside double quotes are called a _string_. The two numbers determine the `x` and `y` coordinates of the text (specifically, its bottom-left corner). Before we print text, however, we need to set the color of the text (it is white by default). The `fill(r, g, b)` command sets the color based on the red, green, and blue values given.  From now on, we'll be referring to these commands as _functions_.  
    ```javascript
    fill(0, 0, 0);
    text("Hello world!", 0, 0); //Print text
    text("Hi there", 100, 100);
    text("This is below the other ones", 100, 200);
    ```  
1. Any line prefaced by `//` is a _comment_. It will not be executed by the computer and exists only for the benefit of humans reading the program. Comment any part of a program that could be confusing so that other coders will know what the code does.
1. Type `rect(0, 0, 100, 100);` into the left box. `rect` is a command that draws a rectangle and the numbers (called _arguments_) are data given to the command The first two numbers are the `x` and `y` coordinates of the top left corner of the rectangle, just like the `text()` function. The third and fourth numbers are the `width` and `height` of the rectangle. You can hover over each of the numbers and drag the slider back and forth to see how the rectangle changes as each of the numbers change.
1. Try out some of the other drawing commands such as `ellipse`, `line`, and `quad`. Look at the references section to know how many arguments to give each function. In addition, look at the house below and try to re-create it using your drawing functions. Be sure to pay attention to the order of functions as that will determine which shapes are on "top" of the drawing.  
![The house you should try to re-create.](images/section_3/academy_house.PNG)

## Variables
Variables are containers that can hold different values in different parts of the program. They may hold a character, a number, or a string (which is a collection of characters such as "hello"). Variables are very useful when dealing with loops and user input, as they allow you to call a function without actually specifying the exact number for the argument.

1. When using a variable, we must first _declare_ the variable. Type `var x = 10;` to create a new variable `x` and set it equal to 10. Then, run `rect(100, 100, 10, 10);` and `rect(200, 100, x, x);`. Notice that the rectangles are the same size since `x` is equal to 10.
1. Now try setting `x` to different numbers using just `x = 25`. The keyword `var` is only necessary when you first declare a variable. An example program is below.
    ```javascript
    var x = 10;
    rect(100, 100, x, x);
    x = 20;
    rect(100, 100, x, x);
    x = x + 10;
    rect(100, 100, x, x);
    ```

## Conditionals

Conditionals allow you to control the flow of your program. The `if` and `else` statements are the main two that we will look at. Conditionals operate on the same boolean logic that we learned on day 1.

1. Type the following program into your window. The blocks of code contained by braces `{}` run only if their corresponding `if` statement evaluates to true.
    ```javascript
    if (10 < 20)
    {
        fill(255, 0, 0);
        rect(150, 250, 100, 150);
    }

    if (20 < 20)
    {
        fill(0, 255, 0);
        rect(150, 250, 100, 150);
    }

    if (30 < 20)
    {
        fill(0, 0, 255);
        rect(150, 250, 100, 150);
    }
    ```
1. `else` statements must follow `if` statements, and run when the `if` statement evaluates to false.
    ```javascript
    if (8 >= 8)
    {
        fill(255, 0, 0);
    }
    else
    {
        fill(255, 0, 0);
    }

    rect(150, 250, 100, 150);
    ```

## Loops

Loops provide a way to execute the same commands multiple times. Each execution of the block (called an _iteration_ when dealing with loops) depends on the result of a _boolean expression_, just like with `if` statements.

### WHILE loops

The body of `while` loops execute when the boolean of the `while` evaluates to `true`. The syntax for a while loop is below. Notice the form of the boolean expression after the keyword `while`.

```javascript
while (x < 10)
{
    //Code body here
}
```

Execute the following program. Notice that we make a change to the value of `x`.

```javascript
var x = 0;
while (x < 200)
{
    ellipse(x, 100, 50, 50);
    x = x + 50;
}
```

What happens if we run the same program without changing the value of `x`? Comment out the line `x = x + 50` by putting `//` in front of it. Khan Academy will give you a popup saying your program took too long to execute. Since the value of `x` never changes, the expression `x < 200` is always true and so the `while` loop will repeat forever. A loop that never ends is called an _infinite loop_ and they should generally be avoided if possible.

### FOR loops

`for` loops are more structured that `while` loops. To write a `for` loop, you specify a starting point, an ending point, and an action to be performed every iteration. The following code block shows the basic syntax of a `for` loop.

```javascript
for (var i = 1; i < 10; i = i + 1) //Notice we actually declare the variable i inside the parentheses
{
    //Code goes here
}
```

`var i = 1;` is executed when the program reaches the `for` loop for the first time. `i < 10;` is the condition that is checked at the end of each run, similar to the expression for the `while` loop. The last statement `i = i + 1` is executed at the end of iteration of the loop. It serves the same purpose as our `x = x + 50` in the `while` loop from earlier.

Now, run the following program. Change some of the variables in the loop declaration to see what they do.

```javascript
noFill(); //This makes shapes transparent except for the edges
for (var i = 10; i < 200; i = i + 20)
{
    ellipse(200, 200, i, i);
}

for (var i = 0; i < 400; i = i + 40)
{
    rect(i, i, 20, 20);
}
```

### Bouncing Ball Program

This program is a bouncing ball program. Go ahead and execute and watch the animation. Take a look at the code and read the comments. We'll be going over this on the projector so if you're confused feel free to ask any questions.

```javascript
var x = 150; //X position of the circle
var y = 25; //Y position of the circle

var xSpeed = 5;
var ySpeed = 5;

//Here we are creating our own function. Any function called "draw"
//is automatically executed by the program over and over, so we don't
//need to have any real loop.
var draw = function() {
    background(255, 255, 255);

    //Draw the circle
    fill(255, 0, 0);
    ellipse(x, y, 50, 50);

    //If the circle hits the left or right wall, reverse its movement
    //in the X direction
    if (x < 25 || x > 375)
    {
        xSpeed = -xSpeed;
    }

    //If the circle hits the top or bottom wall, reverse its movement
    //in the Y direction
    if (y < 25 || y > 375)
    {
        ySpeed = -ySpeed;
    }

    //Move the circle before the next iteration
    x = x + xSpeed;
    y = y + ySpeed;
};
```
