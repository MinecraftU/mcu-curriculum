# Making basic items

In this section, we will be referencing `mbe10_item_simple`. 



---

## On-click effects

# Recipes

Now we need to make our new blocks and items useful by creating some recipes! There are two types of recipes we can create: shapeless and shaped. Shapeless recipes (such as making wooden planks from wood) don't require the items to be in any specific orientation to work. Shaped recipes (such as making a pickaxe or shovel) require blocks to be in specific locations for the recipe to function.

### Shapeless recipes

First, let's make a shapeless recipe.

### Shaped recipes

Next, let's make a shaped recipe. Shaped recipes group the rows of items using letters to represent the type of block. For example, the recipe for TNT would be: `("xyx", "yxy", "xyx", 'x', new ItemStack(Materials.sulphur), 'y', new ItemStack(Blocks.sand))` where `x` corresponds to sulphur (the name for gunpowder in the game code) and `y` corresponds to sand. Pay attention to the double-quotes for the letters representing the recipe shape and the single-quotes for the letters representing the items in the recipe.

> Note: when we leave out the size of the ItemStack, the game will assume a size of 1.

## Smelting recipes

Smelting recipes are very similar and only require a slightly different function call.

