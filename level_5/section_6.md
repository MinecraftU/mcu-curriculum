# Creating foods

In this section, we will be referencing `mbe16_item_food`. 

This one is pretty basic. Look in `ItemSandwich.java`:

```java
public class ItemSandwich extends ItemFood {
  public ItemSandwich() {
    //int amount, float saturation, boolean isWolfFood
    super(1, 1, false);
    setAlwaysEdible();
  }
}
```

We're again just extending the native `ItemFood` object, calling `super` with three parameters described in the comments. We call `setAlwaysEdible` so that we can eat this food at any time, even when we're not hungy (that way we don't have to run around just to test it).

In `StartupCommon.java` we create our sandwich:

```java
itemSandwich = (ItemSandwich)(new ItemSandwich().setUnlocalizedName("mbe16_item_food_unlocalised_name"));
    itemSandwich.setRegistryName("mbe16_item_food_registry_name");
    ForgeRegistries.ITEMS.register(itemSandwich);
```

In `StartupClientOnly.java` we define the resource location as normal:

```java
ModelResourceLocation itemModelResourceLocation = new ModelResourceLocation("minecraftbyexample:mbe16_item_food", "inventory");
    final int DEFAULT_ITEM_SUBTYPE = 0;
    ModelLoader.setCustomModelResourceLocation(StartupCommon.itemSandwich, DEFAULT_ITEM_SUBTYPE, itemModelResourceLocation);
```

That's it, we have a new food item called sandwich.

## Putting potion effects on food

The example code for adding potion effects was _commented out_ before so that you could see the food without the effects. Un-comment the lines following `// to give potion effects:` in the imports section and below the constructor.

```java
@Override
protected void onFoodEaten(ItemStack stack, World worldIn, EntityPlayer player) {
  if(!worldIn.isRemote) {
    player.addPotionEffect(new PotionEffect(MobEffects.JUMP_BOOST, 60*20, 5, false, true));
  }
}

@SideOnly(Side.CLIENT)
public boolean hasEffect(ItemStack stack)
{
  return true;
}
```

# Crops

In this section, we will be referencing `mbe17_block_crops`.



