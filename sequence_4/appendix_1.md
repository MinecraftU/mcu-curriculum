# Creating mobs

Mobs are living entities that move around in the world. Minecraft has categories of mobs that are passive, neutral,
hostile, and tamable. An example of each would be a Cow, Spider, Creeper, and Wolf.

For our example, we will create a human mob that will attack hostile mobs and you if attacked. Each mob needs three
main components:
1. A renderer class. This is used for advanced graphics drawing, which we will only use it for model textures now.
2. A model class. This is used to modify the shape of our entity.
3. An entity class. This is where we add our entity properties and AI behaviors.

Here is the rendering class we will use to create our human mob.

```java
package com.example.coppermod;

import net.minecraft.client.model.ModelBiped;
import net.minecraft.client.renderer.entity.RenderBiped;
import net.minecraft.entity.Entity;
import net.minecraft.entity.EntityLiving;
import net.minecraft.util.ResourceLocation;

public class RenderHuman extends RenderBiped {
    private static final ResourceLocation humanTexture = new ResourceLocation(CopperMod.MODID,
            "textures/entity/human.png");

    public RenderHuman() {
        super(new ModelBiped(), 0.6f);
    }

    @Override
    protected ResourceLocation getEntityTexture(EntityLiving entity) {
        return humanTexture;
    }

    @Override
    protected ResourceLocation getEntityTexture(Entity entity) {
        return humanTexture;
    }
}
```

Next we would create the model class, but since we will be using the default human model and are not modifying it,
we don't need to create a new class. So the last class to create is the entity class.

```java
package com.example.coppermod;

import net.minecraft.entity.EntityCreature;
import net.minecraft.world.World;
import net.minecraft.init.Items;
import net.minecraft.item.Item;

public class EntityHuman extends EntityCreature {
    public EntityHuman(World world) {
        super(world);
        this.experienceValue = 5;
        this.setEquipmentDropChance(0, 0.75f);
    }

    @Override
    protected Item getDropItem() {
        return Items.gold_nugget;
    }
}
```

We will come back to this class to add our AI behavior and other properties. Now all that is left is to register
our entity in the main mod class.

```java
int humanEntityId = EntityRegistry.findGlobalUniqueEntityId();
int eggBackgroundColor = (255 << 8) + 255; // Aqua
int eggForegroundColor = (40 << 16) + (40 << 8) + 115; // Dark blue

EntityRegistry.registerGlobalEntityID(EntityHuman.class, "entity_human", humanEntityId,
        eggBackgroundColor, eggForegroundColor);
EntityRegistry.registerModEntity(EntityHuman.class, "entity_human", humanEntityId,
        this, 80, 1, true);
EntityRegistry.addSpawn(EntityHuman.class, 1, 1, 3, EnumCreatureType.ambient, BiomeGenBase.plains,
        BiomeGenBase.forest, BiomeGenBase.forestHills, BiomeGenBase.taiga);

RenderingRegistry.registerEntityRenderingHandler(EntityHuman.class, new RenderHuman());
```

The `EntityRegistry.addSpawn` method makes our mobs spwan in the world. The first argument is the new entity class we
want to spawn in the world. The rest of the arguments are as follows:
* weightedProbability: The higher the number, the greater the chance of your mobs spawning.
* minGroupCount and maxGroupCount: This sets what the minimum and maximum group sizes that Minecraft will spawn.
* typeOfCreature: This affects the spawning locations of you mob.
* biomes: This is were you can select which biomes you want you mob to spawn in. You can select as many as you want.

Now grab the spawn egg or explore the biomes to find your mob!

![Spawning a human entity.](images/appendices/a1_spawn_test.png)

## Entity properties and AI behaviors

You may notice that our mob does not do anything. AI tasks are the main way to make our mobs do things. For example,
`this.tasks.addTask(2, new EntityAIWander(this, 1.0D));` creates a task of priority 2 that makes the AI wander in the
world. You can add these tasks in the constructor. Try experimenting with different available AI tasks to see what
they do!

We can also set some properties of our mobs like the health, speed, and more. For example,
`this.getEntityAttribute(SharedMonsterAttributes.movementSpeed).setBaseValue(0.3D);` sets our mob's movement speed to
about the speed that the player can walk.

Lastly, we can select which classes our mob will attack with `this.targetTasks.addTask` method. Below is our full mob
class which shows how you can add your entity properties and AI behaviors.

```java
package com.example.coppermod;

import net.minecraft.enchantment.EnchantmentHelper;
import net.minecraft.entity.Entity;
import net.minecraft.entity.EntityCreature;
import net.minecraft.entity.EntityLivingBase;
import net.minecraft.entity.SharedMonsterAttributes;
import net.minecraft.entity.ai.*;
import net.minecraft.entity.monster.*;
import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.init.Items;
import net.minecraft.item.Item;
import net.minecraft.util.DamageSource;
import net.minecraft.util.MathHelper;
import net.minecraft.world.EnumDifficulty;
import net.minecraft.world.World;

public class EntityHuman extends EntityCreature {
    public EntityHuman(World world) {
        super(world);
        this.experienceValue = 5;
        this.setEquipmentDropChance(0, 0.75f);
        this.setHealth(this.getMaxHealth());

        this.getNavigator().setCanSwim(true);
        this.getNavigator().setEnterDoors(true);

        this.tasks.addTask(0, new EntityAISwimming(this));
        this.tasks.addTask(1, new EntityAIAttackOnCollide(this, 1.0D, false));
        this.tasks.addTask(2, new EntityAIWander(this, 1.0D));
        this.tasks.addTask(3, new EntityAIWatchClosest(this, EntityPlayer.class, 8.0f));
        this.tasks.addTask(4, new EntityAILookIdle(this));

        this.targetTasks.addTask(1, new EntityAINearestAttackableTarget(this, EntityZombie.class, 0, true));
        this.targetTasks.addTask(1, new EntityAINearestAttackableTarget(this, EntitySkeleton.class, 0, true));
        this.targetTasks.addTask(1, new EntityAINearestAttackableTarget(this, EntityEnderman.class, 0, true));
        this.targetTasks.addTask(2, new EntityAIHurtByTarget(this, false));
    }

    @Override
    protected Item getDropItem() {
        return Items.gold_nugget;
    }

    @Override
    protected void applyEntityAttributes() {
        super.applyEntityAttributes();

        this.getAttributeMap().registerAttribute(SharedMonsterAttributes.attackDamage);
        this.getEntityAttribute(SharedMonsterAttributes.attackDamage).setBaseValue(3.0D);
        this.getEntityAttribute(SharedMonsterAttributes.maxHealth).setBaseValue(25.0D);
        this.getEntityAttribute(SharedMonsterAttributes.movementSpeed).setBaseValue(0.3D);
        this.getEntityAttribute(SharedMonsterAttributes.knockbackResistance).setBaseValue(0.25D);
    }

    @Override
    protected boolean isAIEnabled() {
        return true;
    }

    /**
     * Called frequently so the entity can update its state every tick as required. For example, zombies and
     * skeletons use this to react to sunlight and start to burn.
     */
    public void onLivingUpdate() {
        this.updateArmSwingProgress();
        float f = this.getBrightness(1.0F);

        if (f > 0.5F) {
            this.entityAge += 2;
        }

        super.onLivingUpdate();
    }

    /**
     * Called to update the entity's position/logic.
     */
    public void onUpdate() {
        super.onUpdate();

        if (!this.worldObj.isRemote && this.worldObj.difficultySetting == EnumDifficulty.PEACEFUL) {
            this.setDead();
        }
    }

    protected String getSwimSound() {
        return "game.hostile.swim";
    }

    protected String getSplashSound() {
        return "game.hostile.swim.splash";
    }

    /**
     * Finds the closest player within 16 blocks to attack, or null if this Entity isn't interested in attacking
     * (Animals, Spiders at day, peaceful PigZombies).
     */
    protected Entity findPlayerToAttack() {
        EntityPlayer entityplayer = this.worldObj.getClosestVulnerablePlayerToEntity(this, 16.0D);
        return entityplayer != null && this.canEntityBeSeen(entityplayer) ? entityplayer : null;
    }

    /**
     * Called when the entity is attacked.
     */
    public boolean attackEntityFrom(DamageSource p_70097_1_, float p_70097_2_) {
        if (this.isEntityInvulnerable()) {
            return false;
        } else if (super.attackEntityFrom(p_70097_1_, p_70097_2_)) {
            Entity entity = p_70097_1_.getEntity();

            if (this.riddenByEntity != entity && this.ridingEntity != entity) {
                if (entity != this) {
                    this.entityToAttack = entity;
                }

                return true;
            } else {
                return true;
            }
        } else {
            return false;
        }
    }

    /**
     * Returns the sound this mob makes when it is hurt.
     */
    protected String getHurtSound() {
        return "game.hostile.hurt";
    }

    /**
     * Returns the sound this mob makes on death.
     */
    protected String getDeathSound() {
        return "game.hostile.die";
    }

    protected String func_146067_o(int p_146067_1_) {
        return p_146067_1_ > 4 ? "game.hostile.hurt.fall.big" : "game.hostile.hurt.fall.small";
    }

    public boolean attackEntityAsMob(Entity p_70652_1_) {
        float f = (float) this.getEntityAttribute(SharedMonsterAttributes.attackDamage).getAttributeValue();
        int i = 0;

        if (p_70652_1_ instanceof EntityLivingBase) {
            f += EnchantmentHelper.getEnchantmentModifierLiving(this, (EntityLivingBase) p_70652_1_);
            i += EnchantmentHelper.getKnockbackModifier(this, (EntityLivingBase) p_70652_1_);
        }

        boolean flag = p_70652_1_.attackEntityFrom(DamageSource.causeMobDamage(this), f);

        if (flag) {
            if (i > 0) {
                p_70652_1_.addVelocity((double) (-MathHelper.sin(this.rotationYaw * (float) Math.PI / 180.0F)
                * (float) i * 0.5F), 0.1D, (double) (MathHelper.cos(this.rotationYaw * (float) Math.PI / 180.0F)
                * (float) i * 0.5F));
                this.motionX *= 0.6D;
                this.motionZ *= 0.6D;
            }

            int j = EnchantmentHelper.getFireAspectModifier(this);

            if (j > 0) {
                p_70652_1_.setFire(j * 4);
            }

            if (p_70652_1_ instanceof EntityLivingBase) {
                EnchantmentHelper.func_151384_a((EntityLivingBase) p_70652_1_, this);
            }

            EnchantmentHelper.func_151385_b(this, p_70652_1_);
        }

        return flag;
    }

    /**
     * Basic mob attack. Default to touch of death in EntityCreature. Overridden by each mob to define their attack.
     */
    protected void attackEntity(Entity p_70785_1_, float p_70785_2_) {
        if (this.attackTime <= 0 && p_70785_2_ < 2.0F && p_70785_1_.boundingBox.maxY > this.boundingBox.minY &&
        p_70785_1_.boundingBox.minY < this.boundingBox.maxY) {
            this.attackTime = 20;
            this.attackEntityAsMob(p_70785_1_);
        }
    }

    /**
     * Checks if the entity's current position is a valid location to spawn this entity.
     */
    public boolean getCanSpawnHere() {
        return this.worldObj.difficultySetting != EnumDifficulty.PEACEFUL && super.getCanSpawnHere();
    }

    protected boolean func_146066_aG() {
        return true;
    }
}
```

![Human mob attacking a skeleton.](images/appendices/a1_entity_attack.png)