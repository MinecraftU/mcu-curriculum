# Generating ore

In this section, we will be referencing `mbe09_ore_spawning`. We're going to make diamond blocks randomly generate in dirt!

![](images/section_5/generate_diamond.png)

Almost all of the required code is in `mbe09_ore_spawning/OreSpawner.java`. Let's start towards the bottom of the file, with `addOreSpawn`. As the comment above the method definition explains, this is a utility method that allows us to create multiple ore spawns easily. Here we add some formatting for readability:

```java
private void addOreSpawn(
  WorldGenerator generator, 
  World world, 
  Random random, 
  int blockXPos, 
  int blockZPos,
  int chancesToSpawn, 
  int minY, 
  int maxY) {
```

(Typically, a method definition such as this should be kept to as few lines as possible.)

We can see this utility (or _helper_) method takes a number of parameters: a `WorldGenerator` (which we sill look at in a minute), a `World` (!), `Random` (from `java.until.Random`), and five integers all named intuitively.

The next piece of code we want to look at is:

```java
private WorldGenerator diamondSpawner = new WorldGenMinable(
    Blocks.DIAMOND_BLOCK.getDefaultState(), // the block to spawn
    16, // the size of the vein
    BlockMatcher.forBlock(Blocks.DIRT)); // the block to replace
```

Again, the author has formatted this code for readability and added comments so we know what each section is for. It's going to create 16 block veins of diamond blocks in the place of dirt.

Finally the `generate` method is going to call our `addOreSpawn` helper method.

To discover this working in the wild, fly around to generate new chunks and look for dirt. You should quickly discover some exposed diamond blocks.

Now add another ore spawner to replace some stone blocks with gold blocks.

```java
private WorldGenerator goldSpawner = new WorldGenMinable(
    Blocks.GOLD_BLOCK.getDefaultState(),
    16,
    BlockMatcher.forBlock(Blocks.STONE));
```

...

```java
addOreSpawn(goldSpawner, world, random, chunkX * CHUNK_SIZE, chunkZ * CHUNK_SIZE, 64, 15, 160);
```

![](images/section_5/we_are_rich.png)
