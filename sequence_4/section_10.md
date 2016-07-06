# Creating a bow and arrow

## Creating the bow
```java
package com.example.coppermod;

import cpw.mods.fml.relauncher.Side;
import cpw.mods.fml.relauncher.SideOnly;
import net.minecraft.client.renderer.texture.IIconRegister;
import net.minecraft.enchantment.Enchantment;
import net.minecraft.enchantment.EnchantmentHelper;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.item.ItemBow;
import net.minecraft.item.ItemStack;
import net.minecraft.util.IIcon;
import net.minecraft.world.World;
import net.minecraftforge.common.MinecraftForge;
import net.minecraftforge.event.entity.player.ArrowLooseEvent;
import net.minecraftforge.event.entity.player.ArrowNockEvent;

public class ItemExplodingBow extends ItemBow {
    public static final String[] explodingBowPullIconNameArray = new String[]{"pulling_0", "pulling_1", "pulling_2"};
    @SideOnly(Side.CLIENT)
    public IIcon[] iconArray;

    // Used for item rendering in third person
    public int bowIconRenderStage = -1;

    public ItemExplodingBow() {
        this.setUnlocalizedName("exploding_bow");
        this.setTextureName(CopperMod.MODID + ":exploding_bow");
        this.setFull3D();
    }

    @Override
    public void onPlayerStoppedUsing(ItemStack itemStack, World world, EntityPlayer player, int itemInUseCount) {
        int j = this.getMaxItemUseDuration(itemStack) - itemInUseCount;

        ArrowLooseEvent event = new ArrowLooseEvent(player, itemStack, j);
        MinecraftForge.EVENT_BUS.post(event);
        if (event.isCanceled()) {
            return;
        }
        j = event.charge;

        boolean flag = player.capabilities.isCreativeMode || EnchantmentHelper.getEnchantmentLevel(
                Enchantment.infinity.effectId, itemStack) > 0;

        if (flag || player.inventory.hasItem(CopperMod.explodingArrow)) {
            float f = (float) j / 20.0F;
            f = (f * f + f * 2.0F) / 3.0F;

            if ((double) f < 0.1D) {
                return;
            }

            if (f > 1.0F) {
                f = 1.0F;
            }

            EntityExplodingArrow entityarrow = new EntityExplodingArrow(world, player, f * 2.0F);

            if (f == 1.0F) {
                entityarrow.setIsCritical(true);
            }

            int k = EnchantmentHelper.getEnchantmentLevel(Enchantment.power.effectId, itemStack);

            if (k > 0) {
                entityarrow.setDamage(entityarrow.getDamage() + (double) k * 0.5D + 0.5D);
            }

            int l = EnchantmentHelper.getEnchantmentLevel(Enchantment.punch.effectId, itemStack);

            if (l > 0) {
                entityarrow.setKnockbackStrength(l);
            }

            if (EnchantmentHelper.getEnchantmentLevel(Enchantment.flame.effectId, itemStack) > 0) {
                entityarrow.setFire(100);
            }

            itemStack.damageItem(1, player);
            world.playSoundAtEntity(player, "random.bow", 1.0F, 1.0F / (itemRand.nextFloat() * 0.4F + 1.2F) + f * 0.5F);

            if (flag) {
                entityarrow.canBePickedUp = 2;
            } else {
                player.inventory.consumeInventoryItem(CopperMod.explodingArrow);
            }

            if (!world.isRemote) {
                world.spawnEntityInWorld(entityarrow);
            }
        }

        bowIconRenderStage = -1;
    }

    @Override
    public ItemStack onItemRightClick(ItemStack itemStack, World world, EntityPlayer player) {
        ArrowNockEvent event = new ArrowNockEvent(player, itemStack);
        MinecraftForge.EVENT_BUS.post(event);
        if (event.isCanceled()) {
            return event.result;
        }

        if (player.capabilities.isCreativeMode || player.inventory.hasItem(CopperMod.explodingArrow)) {
            player.setItemInUse(itemStack, this.getMaxItemUseDuration(itemStack));
        }

        return itemStack;
    }

    @Override
    @SideOnly(Side.CLIENT)
    public void registerIcons(IIconRegister register) {
        this.itemIcon = register.registerIcon(this.getIconString() + "_standby");
        this.iconArray = new IIcon[explodingBowPullIconNameArray.length];

        for (int i = 0; i < this.iconArray.length; ++i) {
            this.iconArray[i] = register.registerIcon(this.getIconString() + "_" + explodingBowPullIconNameArray[i]);
        }
    }

    @Override
    @SideOnly(Side.CLIENT)
    public IIcon getIcon(ItemStack stack, int renderPass, EntityPlayer player, ItemStack usingItem, int useRemaining) {
        if (usingItem == null || useRemaining == 0) {
            bowIconRenderStage = -1;
            return this.itemIcon;
        }

        int ticksUsed = stack.getMaxItemUseDuration() - useRemaining;

        if (ticksUsed >= 18) {
            bowIconRenderStage = 2;
            return this.iconArray[2];
        } else if (ticksUsed > 13) {
            bowIconRenderStage = 1;
            return this.iconArray[1];
        } else if (ticksUsed > 0) {
            bowIconRenderStage = 0;
            return this.iconArray[0];
        }

        return this.itemIcon;
    }
}
```

## Creating the arrow item
```java
package com.example.coppermod;

import net.minecraft.creativetab.CreativeTabs;
import net.minecraft.item.Item;

public class ItemExplodingArrow extends Item {
    public ItemExplodingArrow() {
        this.setUnlocalizedName("exploding_arrow");
        this.setCreativeTab(CreativeTabs.tabCombat);
        this.setTextureName(CopperMod.MODID + ":exploding_arrow");
    }
}
```

## Creating the arrow entity

```java
package com.example.coppermod;

import net.minecraft.block.Block;
import net.minecraft.block.material.Material;
import net.minecraft.enchantment.EnchantmentHelper;
import net.minecraft.entity.Entity;
import net.minecraft.entity.EntityLivingBase;
import net.minecraft.entity.monster.EntityEnderman;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.entity.player.EntityPlayerMP;
import net.minecraft.entity.projectile.EntityArrow;
import net.minecraft.network.play.server.S2BPacketChangeGameState;
import net.minecraft.util.*;
import net.minecraft.world.World;

import java.lang.reflect.Field;
import java.util.List;

public class EntityExplodingArrow extends EntityArrow {
    private Field field_145791_d;
    private Field field_145792_e;
    private Field field_145789_f;
    private Field field_145790_g;
    private Field inData;
    private Field inGround;
    /**
     * 1 if the player can pick up the arrow
     */
    private Field ticksInGround;
    private int ticksInAir;
    private Field damage;
    /**
     * The amount of knockback an arrow applies when it hits a mob.
     */
    private Field knockbackStrength;

    public EntityExplodingArrow(World world, EntityLivingBase shootingEntity, float direction) {
        super(world, shootingEntity, direction);

        try {
            field_145791_d = EntityArrow.class.getDeclaredField("field_145791_d");
            field_145791_d.setAccessible(true);
            field_145792_e = EntityArrow.class.getDeclaredField("field_145792_e");
            field_145792_e.setAccessible(true);
            field_145789_f = EntityArrow.class.getDeclaredField("field_145789_f");
            field_145789_f.setAccessible(true);
            field_145790_g = EntityArrow.class.getDeclaredField("field_145790_g");
            field_145790_g.setAccessible(true);
            inData = EntityArrow.class.getDeclaredField("inData");
            inData.setAccessible(true);
            inGround = EntityArrow.class.getDeclaredField("inGround");
            inGround.setAccessible(true);
            ticksInGround = EntityArrow.class.getDeclaredField("ticksInGround");
            ticksInGround.setAccessible(true);
            damage = EntityArrow.class.getDeclaredField("damage");
            damage.setAccessible(true);
            damage.setDouble(this, 2.0D);
            knockbackStrength = EntityArrow.class.getDeclaredField("knockbackStrength");
            knockbackStrength.setAccessible(true);


        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onUpdate() {
        this.onEntityUpdate();

        if (this.prevRotationPitch == 0.0F && this.prevRotationYaw == 0.0F) {
            float f = MathHelper.sqrt_double(this.motionX * this.motionX + this.motionZ * this.motionZ);
            this.prevRotationYaw = this.rotationYaw =
                    (float) (Math.atan2(this.motionX, this.motionZ) * 180.0D / Math.PI);
            this.prevRotationPitch = this.rotationPitch =
                    (float) (Math.atan2(this.motionY, (double) f) * 180.0D / Math.PI);
        }

        try {
            Block block = this.worldObj.getBlock(this.field_145791_d.getInt(this),
                    this.field_145792_e.getInt(this), this.field_145789_f.getInt(this));

            if (block.getMaterial() != Material.air) {
                block.setBlockBoundsBasedOnState(this.worldObj, this.field_145791_d.getInt(this),
                        this.field_145792_e.getInt(this), this.field_145789_f.getInt(this));
                AxisAlignedBB axisalignedbb = block.getCollisionBoundingBoxFromPool(this.worldObj,
                        this.field_145791_d.getInt(this), this.field_145792_e.getInt(this),
                        this.field_145789_f.getInt(this));

                if (axisalignedbb != null && axisalignedbb.isVecInside(Vec3.createVectorHelper(this.posX, this.posY,
                        this.posZ))) {
                    this.inGround.setBoolean(this, true);
                }
            }

            if (this.arrowShake > 0) {
                --this.arrowShake;
            }

            if (this.inGround.getBoolean(this)) {
                int j = this.worldObj.getBlockMetadata(this.field_145791_d.getInt(this),
                        this.field_145792_e.getInt(this), this.field_145789_f.getInt(this));

                if (block == (Block) this.field_145790_g.get(this) && j == this.inData.getInt(this)) {
                    ticksInGround.setInt(this, ticksInGround.getInt(this) + 1);

                    if (this.ticksInGround.getInt(this) == 1) {
                        this.setDead();
                        this.worldObj.createExplosion(null, this.posX, this.posY, this.posZ, 3.0f, true);
                    }
                } else {
                    this.inGround.setBoolean(this, false);
                    this.motionX *= (double) (this.rand.nextFloat() * 0.2F);
                    this.motionY *= (double) (this.rand.nextFloat() * 0.2F);
                    this.motionZ *= (double) (this.rand.nextFloat() * 0.2F);
                    this.ticksInGround.setInt(this, 0);
                    this.ticksInAir = 0;
                }
            } else {
                ++this.ticksInAir;
                Vec3 vec31 = Vec3.createVectorHelper(this.posX, this.posY, this.posZ);
                Vec3 vec3 = Vec3.createVectorHelper(this.posX + this.motionX,
                        this.posY + this.motionY, this.posZ + this.motionZ);
                MovingObjectPosition movingobjectposition = this.worldObj.func_147447_a(vec31, vec3,
                        false, true, false);
                vec31 = Vec3.createVectorHelper(this.posX, this.posY, this.posZ);
                vec3 = Vec3.createVectorHelper(this.posX + this.motionX,
                        this.posY + this.motionY, this.posZ + this.motionZ);

                if (movingobjectposition != null) {
                    vec3 = Vec3.createVectorHelper(movingobjectposition.hitVec.xCoord,
                            movingobjectposition.hitVec.yCoord, movingobjectposition.hitVec.zCoord);
                }

                Entity entity = null;
                List list = this.worldObj.getEntitiesWithinAABBExcludingEntity(this, this.boundingBox.addCoord(
                        this.motionX, this.motionY, this.motionZ).expand(1.0D, 1.0D, 1.0D));
                double d0 = 0.0D;
                int i;
                float f1;

                for (i = 0; i < list.size(); ++i) {
                    Entity entity1 = (Entity) list.get(i);

                    if (entity1.canBeCollidedWith() && (entity1 != this.shootingEntity || this.ticksInAir >= 5)) {
                        f1 = 0.3F;
                        AxisAlignedBB axisalignedbb1 = entity1.boundingBox.expand((double) f1,
                                (double) f1, (double) f1);
                        MovingObjectPosition movingobjectposition1 = axisalignedbb1.calculateIntercept(vec31, vec3);

                        if (movingobjectposition1 != null) {
                            double d1 = vec31.distanceTo(movingobjectposition1.hitVec);

                            if (d1 < d0 || d0 == 0.0D) {
                                entity = entity1;
                                d0 = d1;
                            }
                        }
                    }
                }

                if (entity != null) {
                    movingobjectposition = new MovingObjectPosition(entity);
                }

                if (movingobjectposition != null && movingobjectposition.entityHit != null &&
                        movingobjectposition.entityHit instanceof EntityPlayer) {
                    EntityPlayer entityplayer = (EntityPlayer) movingobjectposition.entityHit;

                    if (entityplayer.capabilities.disableDamage || this.shootingEntity instanceof EntityPlayer &&
                            !((EntityPlayer) this.shootingEntity).canAttackPlayer(entityplayer)) {
                        movingobjectposition = null;
                    }
                }

                float f2;
                float f4;

                if (movingobjectposition != null) {
                    if (movingobjectposition.entityHit != null) {
                        f2 = MathHelper.sqrt_double(this.motionX * this.motionX +
                                this.motionY * this.motionY + this.motionZ * this.motionZ);
                        int k = MathHelper.ceiling_double_int((double) f2 * this.damage.getDouble(this));

                        if (this.getIsCritical()) {
                            k += this.rand.nextInt(k / 2 + 2);
                        }

                        DamageSource damagesource = null;

                        if (this.shootingEntity == null) {
                            damagesource = DamageSource.causeArrowDamage(this, this);
                        } else {
                            damagesource = DamageSource.causeArrowDamage(this, this.shootingEntity);
                        }

                        if (this.isBurning() && !(movingobjectposition.entityHit instanceof EntityEnderman)) {
                            movingobjectposition.entityHit.setFire(5);
                        }

                        if (movingobjectposition.entityHit.attackEntityFrom(damagesource, (float) k)) {
                            if (movingobjectposition.entityHit instanceof EntityLivingBase) {
                                EntityLivingBase entitylivingbase = (EntityLivingBase) movingobjectposition.entityHit;

                                if (!this.worldObj.isRemote) {
                                    entitylivingbase.setArrowCountInEntity(
                                            entitylivingbase.getArrowCountInEntity() + 1);
                                }

                                if (this.knockbackStrength.getInt(this) > 0) {
                                    f4 = MathHelper.sqrt_double(this.motionX * this.motionX +
                                            this.motionZ * this.motionZ);

                                    if (f4 > 0.0F) {
                                        movingobjectposition.entityHit.addVelocity(
                                                this.motionX * (double) this.knockbackStrength.getInt(this) *
                                                        0.6000000238418579D / (double) f4, 0.1D, this.motionZ *
                                                        (double) this.knockbackStrength.getInt(this) *
                                                        0.6000000238418579D / (double) f4);
                                    }
                                }

                                if (this.shootingEntity != null && this.shootingEntity instanceof EntityLivingBase) {
                                    EnchantmentHelper.func_151384_a(entitylivingbase, this.shootingEntity);
                                    EnchantmentHelper.func_151385_b((EntityLivingBase)
                                            this.shootingEntity, entitylivingbase);
                                }

                                if (this.shootingEntity != null && movingobjectposition.entityHit !=
                                        this.shootingEntity && movingobjectposition.entityHit instanceof EntityPlayer
                                        && this.shootingEntity instanceof EntityPlayerMP) {
                                    ((EntityPlayerMP) this.shootingEntity).playerNetServerHandler.sendPacket(
                                            new S2BPacketChangeGameState(6, 0.0F));
                                }
                            }

                            this.playSound("random.bowhit", 1.0F, 1.2F / (this.rand.nextFloat() * 0.2F + 0.9F));

                            if (!(movingobjectposition.entityHit instanceof EntityEnderman)) {
                                this.setDead();
                            }
                        } else {
                            this.motionX *= -0.10000000149011612D;
                            this.motionY *= -0.10000000149011612D;
                            this.motionZ *= -0.10000000149011612D;
                            this.rotationYaw += 180.0F;
                            this.prevRotationYaw += 180.0F;
                            this.ticksInAir = 0;
                        }
                    } else {
                        this.field_145791_d.setInt(this, movingobjectposition.blockX);
                        this.field_145792_e.setInt(this, movingobjectposition.blockY);
                        this.field_145789_f.setInt(this, movingobjectposition.blockZ);
                        this.field_145790_g.set(this, this.worldObj.getBlock(this.field_145791_d.getInt(this),
                                this.field_145792_e.getInt(this), this.field_145789_f.getInt(this)));
                        this.inData.setInt(this, this.worldObj.getBlockMetadata(this.field_145791_d.getInt(this),
                                this.field_145792_e.getInt(this), this.field_145789_f.getInt(this)));
                        this.motionX = (double) ((float) (movingobjectposition.hitVec.xCoord - this.posX));
                        this.motionY = (double) ((float) (movingobjectposition.hitVec.yCoord - this.posY));
                        this.motionZ = (double) ((float) (movingobjectposition.hitVec.zCoord - this.posZ));
                        f2 = MathHelper.sqrt_double(this.motionX * this.motionX + this.motionY * this.motionY
                                + this.motionZ * this.motionZ);
                        this.posX -= this.motionX / (double) f2 * 0.05000000074505806D;
                        this.posY -= this.motionY / (double) f2 * 0.05000000074505806D;
                        this.posZ -= this.motionZ / (double) f2 * 0.05000000074505806D;
                        this.playSound("random.bowhit", 1.0F, 1.2F / (this.rand.nextFloat() * 0.2F + 0.9F));
                        this.inGround.setBoolean(this, true);
                        this.arrowShake = 7;
                        this.setIsCritical(false);

                        if (((Block) this.field_145790_g.get(this)).getMaterial() != Material.air) {
                            ((Block) this.field_145790_g.get(this)).onEntityCollidedWithBlock(this.worldObj,
                                    this.field_145791_d.getInt(this), this.field_145792_e.getInt(this),
                                    this.field_145789_f.getInt(this), this);
                        }
                    }
                }

                if (this.getIsCritical()) {
                    for (i = 0; i < 4; ++i) {
                        this.worldObj.spawnParticle("crit", this.posX + this.motionX * (double) i / 4.0D,
                                this.posY + this.motionY * (double) i / 4.0D,
                                this.posZ + this.motionZ * (double) i / 4.0D, -this.motionX, -this.motionY + 0.2D,
                                -this.motionZ);
                    }
                }

                this.posX += this.motionX;
                this.posY += this.motionY;
                this.posZ += this.motionZ;
                f2 = MathHelper.sqrt_double(this.motionX * this.motionX + this.motionZ * this.motionZ);
                this.rotationYaw = (float) (Math.atan2(this.motionX, this.motionZ) * 180.0D / Math.PI);

                for (this.rotationPitch = (float) (Math.atan2(this.motionY, (double) f2) * 180.0D / Math.PI);
                     this.rotationPitch - this.prevRotationPitch < -180.0F; this.prevRotationPitch -= 360.0F) {
                    ;
                }

                while (this.rotationPitch - this.prevRotationPitch >= 180.0F) {
                    this.prevRotationPitch += 360.0F;
                }

                while (this.rotationYaw - this.prevRotationYaw < -180.0F) {
                    this.prevRotationYaw -= 360.0F;
                }

                while (this.rotationYaw - this.prevRotationYaw >= 180.0F) {
                    this.prevRotationYaw += 360.0F;
                }

                this.rotationPitch = this.prevRotationPitch + (this.rotationPitch - this.prevRotationPitch) * 0.2F;
                this.rotationYaw = this.prevRotationYaw + (this.rotationYaw - this.prevRotationYaw) * 0.2F;
                float f3 = 0.99F;
                f1 = 0.05F;

                if (this.isInWater()) {
                    for (int l = 0; l < 4; ++l) {
                        f4 = 0.25F;
                        this.worldObj.spawnParticle("bubble", this.posX - this.motionX * (double) f4,
                                this.posY - this.motionY * (double) f4, this.posZ - this.motionZ * (double) f4,
                                this.motionX, this.motionY, this.motionZ);
                    }

                    f3 = 0.8F;
                }

                if (this.isWet()) {
                    this.extinguish();
                }

                this.motionX *= (double) f3;
                this.motionY *= (double) f3;
                this.motionZ *= (double) f3;
                this.motionY -= (double) f1;
                this.setPosition(this.posX, this.posY, this.posZ);
                this.func_145775_I();
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }
}
```

## Creating our bow renderer
```java
package com.example.coppermod;

import net.minecraft.client.renderer.ItemRenderer;
import net.minecraft.client.renderer.Tessellator;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.item.ItemStack;
import net.minecraft.util.IIcon;
import net.minecraftforge.client.IItemRenderer;
import org.lwjgl.opengl.GL11;
import org.lwjgl.opengl.GL12;

public class RenderExplodingBow implements IItemRenderer {
    @Override
    public boolean handleRenderType(ItemStack item, ItemRenderType type) {
        return type == ItemRenderType.EQUIPPED;
    }

    @Override
    public boolean shouldUseRenderHelper(ItemRenderType type, ItemStack item, ItemRendererHelper helper) {
        return false;
    }

    @Override
    public void renderItem(ItemRenderType type, ItemStack item, Object... data) {
        EntityPlayer entity = (EntityPlayer) data[1];
        ItemExplodingBow bowItem = ((ItemExplodingBow) item.getItem());

        IIcon iicon = bowItem.getIcon(item, 0, entity, item, entity.getItemInUseCount());
        Tessellator tessellator = Tessellator.instance;
        float f = iicon.getMinU();
        float f1 = iicon.getMaxU();
        float f2 = iicon.getMinV();
        float f3 = iicon.getMaxV();
        GL11.glEnable(GL12.GL_RESCALE_NORMAL);
        GL11.glTranslatef(0.1f, -0.3f, 0);
        GL11.glRotatef(20.0f, 1.0f, 0, 0);
        ItemRenderer.renderItemIn2D(tessellator, f1, f2, f, f3, iicon.getIconWidth(), iicon.getIconHeight(), 0.0625F);
    }
}
```

## Registering our bow, arrow, and renderer
```java
explodingArrow = new ItemExplodingArrow();
GameRegistry.registerItem(explodingArrow,MODID + "_" + explodingArrow.getUnlocalizedName());

explodingBow = new ItemExplodingBow();
GameRegistry.registerItem(explodingBow,MODID + "_" + explodingBow.getUnlocalizedName());

RenderExplodingBow bowRenderer = new RenderExplodingBow();
MinecraftForgeClient.registerItemRenderer(explodingBow,bowRenderer);
```