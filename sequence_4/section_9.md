# Making a new set of armor

```java
public static final ItemArmor.ArmorMaterial COPPER_ARMOR =  
    EnumHelper.addArmorMaterial("copper_armor", 20, new int[]{2, 6, 5, 2}, 20);
//durability (diamond = 33), damage done to pieces (helmet down to boots), enchantability
```

```java
//ARMOR
copperHelmet = new ItemCopperArmor(COPPER_ARMOR, 0, "copper_helmet");
GameRegistry.registerItem(copperHelmet, MODID + "_" + copperHelmet.getUnlocalizedName());

copperChestplate = new ItemCopperArmor(COPPER_ARMOR, 1, "copper_chestplate");
GameRegistry.registerItem(copperChestplate, MODID + "_" + copperChestplate.getUnlocalizedName());

copperLegs = new ItemCopperArmor(COPPER_ARMOR, 2, "copper_legs");
GameRegistry.registerItem(copperLegs, MODID + "_" + copperLegs.getUnlocalizedName());

copperBoots = new ItemCopperArmor(COPPER_ARMOR, 3, "copper_boots");
GameRegistry.registerItem(copperBoots, MODID + "_" + copperBoots.getUnlocalizedName());
```

```java
package utd.atvaccaro.coppermod.item;

import utd.atvaccaro.coppermod.CopperMod;
import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.entity.Entity;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.item.ItemArmor;
import net.minecraft.item.ItemStack;
import net.minecraft.potion.Potion;
import net.minecraft.potion.PotionEffect;
import net.minecraft.world.World;

/**
 * Created by atvaccaro on 8/20/14.
 */
public class ItemCopperArmor extends ItemArmor
{
    public ItemCopperArmor(ArmorMaterial material, int armorType, String name)
    {
        super(material, 0, armorType);
        this.setUnlocalizedName(name);
        this.setTextureName(CopperMod.MODID + ":" + getUnlocalizedName().substring(5));
        this.setCreativeTab(CreativeTabs.tabCombat);
    }

    @Override
    public String getArmorTexture(ItemStack stack, Entity entity, int slot, String type)
    {
        if (stack.getItem() == CopperMod.copperLegs)
            return CopperMod.MODID + ":models/armor/copper_layer_2.png";

        else
            return CopperMod.MODID + ":models/armor/copper_layer_1.png";
    }   //end getArmorTexture


    //called on every armor tick
    @Override
    public void onArmorTick(World world, EntityPlayer player, ItemStack armor) {
        //player.addPotionEffect(new PotionEffect(Potion.moveSlowdown.id, 500, 4));  
        //will refresh duration, not stack multiple

        //note that indices for getCurrentArmor are BACKWARDS (eg. 0 = boots, 3 = helm)
        if (player.getCurrentArmor(0) != null && player.getCurrentArmor(0).getItem()
            == CopperMod.copperBoots)
        {
            player.addPotionEffect(new PotionEffect(Potion.jump.getId(), 2, 10));
        }
    }

    //can put in multiple creative tabs
    @Override
    public CreativeTabs[] getCreativeTabs() {
        return new CreativeTabs[] {CreativeTabs.tabCombat, CreativeTabs.tabTools};
        //This lets me put my armor in as many create tabs as I want, pretty cool right?
    }

    //can repair in anvil or not
    @Override
    public boolean getIsRepairable(ItemStack armor, ItemStack stack) {
        return stack.getItem() == CopperMod.copperIngot;
        //Allows certain items to repair this armor.
    }


}
```
