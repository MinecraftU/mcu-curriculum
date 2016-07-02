# Creating crops

```java
package utd.atvaccaro.coppermod.block;

import utd.atvaccaro.coppermod.CopperMod;
import cpw.mods.fml.relauncher.Side;
import cpw.mods.fml.relauncher.SideOnly;
import net.minecraft.block.BlockCrops;
import net.minecraft.client.renderer.texture.IIconRegister;
import net.minecraft.item.Item;
import net.minecraft.item.ItemStack;
import net.minecraft.util.IIcon;
import net.minecraft.world.World;

import java.util.ArrayList;
import java.util.Random;

public class BlockBlueberry extends BlockCrops
{
    @SideOnly(Side.CLIENT)
    protected IIcon[] iIcon;

    public BlockBlueberry()
    {
        // Basic block setup
        setBlockName("blueberries");
        setBlockTextureName("coppermod:blueberries_stage_0");
    }

    /**
     * Returns the quantity of items to drop on block destruction.
     */
    @Override
    public int quantityDropped(int parMetadata, int parFortune, Random parRand)
    {
        return (parMetadata/2);
    }

    @Override
    public Item getItemDropped(int parMetadata, Random parRand, int parFortune)
    {
        // DEBUG
        return (CopperMod.blueberry);
    }

    @Override
    @SideOnly(Side.CLIENT)
    public IIcon getIcon(int side, int stage) { return iIcon[stage]; }

    @Override
    @SideOnly(Side.CLIENT)
    public void registerBlockIcons(IIconRegister parIIconRegister)
    {
        iIcon = new IIcon[8];
        // seems that crops like to have 8 growth icons, but okay to repeat actual texture if you want
        // to make generic should loop to maxGrowthStage
        iIcon[0] = parIIconRegister.registerIcon("coppermod:blueberry_stage_0");
        iIcon[1] = parIIconRegister.registerIcon("coppermod:blueberry_stage_0");
        iIcon[2] = parIIconRegister.registerIcon("coppermod:blueberry_stage_1");
        iIcon[3] = parIIconRegister.registerIcon("coppermod:blueberry_stage_1");
        iIcon[4] = parIIconRegister.registerIcon("coppermod:blueberry_stage_2");
        iIcon[5] = parIIconRegister.registerIcon("coppermod:blueberry_stage_2");
        iIcon[6] = parIIconRegister.registerIcon("coppermod:blueberry_stage_2");
        iIcon[7] = parIIconRegister.registerIcon("coppermod:blueberry_stage_3");
    }

    @Override
    public ArrayList<ItemStack> getDrops(World w, int x, int y, int z, int meta, int fortune) {
        ArrayList<ItemStack> drops = new ArrayList<ItemStack>();
        drops.add(new ItemStack(CopperMod.blueberry));

        if (meta >= 7)
        {
            for (int i = 0; i < 3+fortune; ++i)
            {
                if(w.rand.nextInt(10) <= meta)
                {
                    drops.add(new ItemStack(CopperMod.blueberry));
                }
            }
        }
        return drops;
    }   //end getDrops
}
```

```java
package utd.atvaccaro.coppermod.item;

import utd.atvaccaro.coppermod.CopperMod;
import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.init.Blocks;
import net.minecraft.item.ItemSeedFood;

public class ItemBlueberry extends ItemSeedFood
{

    public ItemBlueberry()
    {
        super(1, 0.3F, CopperMod.blueberryBlock, Blocks.farmland);
        setUnlocalizedName("blueberry");
        setTextureName("coppermod:blueberry");
        setCreativeTab(CreativeTabs.tabFood);
    }
}
```

```java
//CROPS
blueberryBlock = new BlockBlueberry();
GameRegistry.registerBlock(blueberryBlock, MODID + "_" + blueberryBlock.getUnlocalizedName());
blueberry = new ItemBlueberry();
GameRegistry.registerItem(blueberry, MODID + "_" + blueberry.getUnlocalizedName());
```
