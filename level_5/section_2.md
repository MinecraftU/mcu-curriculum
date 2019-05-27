# Making basic blocks

**Anytime you copy Java code in this section, be sure to match ALL capitalization, punctuation, and spacing.**

First we're going to explore some of the examples in the MinecraftByExample repository. Go back to that IntelliJ project. Open the file tree of  `MinecraftByExample`-->`src`-->`main`-->`java`-->`minecraftbyexample`-->`mbe01_block_simple` and double click on the BlockSimple file.

![](images/section_2/open_block_simple.png)

## Core concepts

### Code comments

There are a couple of core concepts visible right at the top of this file. The first one we want you to pay attention to is the comment block at the top. Comments are where the developer of the code can write plain-English instructions or explanations about the code. It's always important to read code comments. The developer put them there for a reason!

```java
/**
 * Code comments can look like this
 */

// code comments can also look like this
```

You can see the developer of the BlockSimple class has written a lot of comments within the file, including their name, the date, a description. They even include helpful links you an follow for more explanation!

### "Extends"

The other core concept is just below the opening comments: the `extends` keyword. Keywords are special words in a programming language that mean specific things. 

In the Minecraft source code, just about everything is represented as a class. There's a class for a diamond pickaxe, for an iron ore, and all other blocks and items. These classes tell what a block (or item) should look like, how it should behave, as well as where it spawns or how it can be crafted. By creating our own classes, we can add our own blocks and items to the game. Let's say that we wanted to make a new type of block. Minecraft already has a `Block` class that defines what a block is in the game (all blocks can be broken and have a texture, for example). We can _extend_ the existing `Block` class and make our own new block. It will have all the normal properties of a block but we can set our own texture, hardness, and sound.

You can see that `BlockSimple` **`extends`** `Block`.

```java
public class BlockSimple extends Block
{
  public BlockSimple()
  {
    super(Material.ROCK);
    this.setCreativeTab(CreativeTabs.BUILDING_BLOCKS);   // the block will appear on the Blocks tab in creative
  }
```

### "Super"

`super` is another keyword. The `super` keyword in Java is a reference variable which is used to refer immediate parent class object.

Whenever you create the instance of subclass, an instance of parent class is created implicitly which is referred by `super` reference variable.

Therefore, the line `super(Material.ROCK)` is calling the `Block` parent class (in this case, its _constructor_). What can you infer from this line of code?

Answer: this new block is going to inherit some properties of Minecraft [Rock](https://minecraft.gamepedia.com/Rock). 

Let's observe this block in the wild. Run the MinecraftByExample project in IntelliJ just as before. Find the block "MBE01 Block Simple" and observe its characteristics. Make sure to observe that when you break the block, it has blue particles, identical to the Lapis particles. It is _inheriting_ those settings from the Lapis block.

![](images/section_2/block_simple.png)

### "README"

Another way developers communicate about their code in plain English is via README files. These can be in various different formats but a common one is called Markdown. Markdown allows some basic formatting using simple text. This curriculum is written in Markdown. These README files in each MinecraftByExample folder will help guide you through each example. Let's experiment with `MBE01 Block Simple`. You can use GitHub to view the formatted README: [https://github.com/MinecraftU/MinecraftByExample/tree/master/src/main/java/minecraftbyexample/mbe01_block_simple](https://github.com/MinecraftU/MinecraftByExample/tree/master/src/main/java/minecraftbyexample/mbe01_block_simple)

First let's change the name of the block. In the README it indicates that the name of the block is in: `resources\assets\minecraftbyexample\lang\en_US.lang`. Find that file:

![](images/section_2/lang_file.png)

Change the name on the first line from `MBE01 Block Simple` to anything else. Example:

```text
tile.mbe01_block_simple_unlocalised_name.name=My Great Block
```

Save your file and re-run the project.

![](images/section_2/renamed_block.png)

Let's change something else. Let's change the particles when the block is broken. It's currently set to inherit that value from Lapis. Let's change that to Emerald. 

Open `resources\assets\minecraftbyexample\models\block\mbe01_block_simple_model.json`:

```json
{
    "parent": "block/cube",
    "textures": {
        "down": "minecraftbyexample:blocks/mbe01_block_simple_face0",
        "up": "minecraftbyexample:blocks/mbe01_block_simple_face1",
        "north": "minecraftbyexample:blocks/mbe01_block_simple_face2",
        "east": "minecraftbyexample:blocks/mbe01_block_simple_face5",
        "south": "minecraftbyexample:blocks/mbe01_block_simple_face3",
        "west": "minecraftbyexample:blocks/mbe01_block_simple_face4",
        "particle": "blocks/lapis_block"
    }
}
```

Now just change the particle definition:

```json
"particle": "blocks/emerald_block"
```

Re-run your project. You'll see the broken block particles for this block are now green, the same as an Emerald block.

### JSON

JSON stands for JavaScript Object Notation, a very common data format. It is used in many different programming languages. 

JSON is formed by _key-value pairs_, like this:

```json
{
    "key": "value"
}
```

So if you wanted to represent a car in JSON, it might look like this:

```json
{
    "manufacturer": "Chevrolet",
    "model": "Corvette",
    "class": "Sports car",
    "body_style":  "2-door coupe",
    "engine": "6.2 L LT5 supercharged V8"
}
```

### Textures

Let's update Block Simple's textures. We'll use new cake textures from [here](images/sections_2/new_textures). Copy these three files into `resources\assets\minecraftbyexample\textures\blocks\`. Then edit `mbe01_block_simple_model.json` as before, but changing the block sides instead:

```json
{
    "parent": "block/cube",
    "textures": {
        "down": "minecraftbyexample:blocks/cyan_glazed_terracotta",
        "up": "minecraftbyexample:blocks/cyan_glazed_terracotta",
        "north": "minecraftbyexample:blocks/cyan_glazed_terracotta",
        "east": "minecraftbyexample:blocks/cyan_glazed_terracotta",
        "south": "minecraftbyexample:blocks/cyan_glazed_terracotta",
        "west": "minecraftbyexample:blocks/cyan_glazed_terracotta",
        "particle": "blocks/lapis_block"
    }
}
```

For more information on block models, see [https://minecraft.gamepedia.com/Model#Block_models](https://minecraft.gamepedia.com/Model#Block_models)
