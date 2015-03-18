# Advanced Modding

## Multi-sided Textures

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

![Our block with multiple textures.](images/section_3/block_texture_multiple.png)

## Changing Item Properties
Many items in Minecraft have specific properties, i.e. Harvest Level, Durability, Block Damage, Entitiy Damage, Enchantablity  
Let's give our custom items a few!

### Custom Tool Material
The easiest way to manipulate these parameters is to simply create our custom item from a custom _Tool Material_.

### Custom enchantability

## Custom Furnace
