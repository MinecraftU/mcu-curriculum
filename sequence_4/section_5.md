# Advanced modding

## Multi-sided textures

What about blocks like grass that have different textures on different sides? The following code in the `CopperBlock` class registers three different textures and tells the program which textures belong on the top, sides, and bottom. If we wanted, we could even make the side textures different (like a furnace or dispenser). You will have to create three texture files matching the names that are being registered.

```java
//Creating our icon variables
private IIcon topIcon;
private IIcon sideIcon;
private IIcon botIcon;

//This function registers our textures to their specific icons
@Override
public void registerBlockIcons(IIconRegister ir)
{
    this.topIcon = ir.registerIcon("coppermod:copper_block_top");
    this.sideIcon = ir.registerIcon("coppermod:copper_block_side");
    this.botIcon = ir.registerIcon("coppermod:copper_block_bottom");
}

//This function tells which icons to use for which sides of the block
@Override
public IIcon getIcon(int side, int par2) //side = the side of the block
{
    if (side == 0) //Bottom
        return botIcon;

    else if (side == 1) //Top
        return topIcon;

    else //all other sides, numbers 2,3,4,5
        return sideIcon;
}
```

For this example, I simply made the top texture a capital 'T' and the bottom texture a capital 'B' so you can see how the registering works.

![](images/section_3/block_texture_multiple.png)

## Changing tool properties
Items in Minecraft have a variety of properties that determine how they behave in-game. These include EntityDamage, Enchantability, and Durability. We can make our own tools (from copper, of course!) and give them their own, unique properties that set them apart from other tools.

### Custom ToolMaterial
The easiest way to manipulate these parameters is to simply create our custom item from a custom _Tool Material_.

### Custom tool effects
By knowing how to override the `hitEntity` function, we can create fire, explosions, and even lightning bolts when our tools are used!

Create the following function definition in one of your item classes.
```java
public boolean hitEntity(ItemStack itemHitting, EntityLivingBase entityBeingHit, EntityLivingBase entityHitting)
{

}
```

This function is called whenever the item is used to hit an entity, whether it's a zombie or a spider or even a cow. The `entityBeingHit` variable points to the `Entity` object being hit in the game, and it is the variable that we can use to give effects to our item. For example, we can set the entity on fire when hit.
```java
public boolean hitEntity(ItemStack itemHitting, EntityLivingBase entityBeingHit, EntityLivingBase entityHitting)
{
    entityBeingHit.setFire(4);  //what do you think the integer does?
}
```

## Custom Crafting Table
Now that we have a set of copper-related blocks, items, and tools, let's make a metalworking bench that is required to turn our ingots into something useful while playing the game. Rather than registering recipes, we extend the existing crafting table code and give it our own recipes.

## Custom Furnace
Making a custom furnace requires significantly more work than a crafting table. A crafting table is purely an interface; you put some items in the slots, and it gives you new items back. A furnace, however, must have _state_. Some class (in this case the `TileEntity` class) must keep track of the current item being smelted, the speed of smelting, the fuel level, and other properties of a running furnace.
