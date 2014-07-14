# qCraft

qCraft is a mod that allows us to use principles of quantum physics.  
All items can be found in creative mode. Recipes can be found at the qCraft wiki:  
https://sites.google.com/a/elinemedia.com/qcraft/wiki/qcraft/blocks-and-items

## 3 Main Principles

The 3 principles you will learn to use are:

1. Observer Dependance
2. Superposition
3. Entanglement

You may also learn to utilize quantum teleportation.

### Observer Dependance

Observational Dependancy essentially states that looking at an object can actually change it.

In Minecraft, imagine a block that is diamond if you observe it from the North, but is coal from the West.

### Superposition

Superposition is a state that includes all possible states.

For example, if I rolled a dice then covered it before it stopped, you wouldn't know if its a 1 or a 6 or a number in between, but you know it is _one_ of those.  However, on a quantum level, the dice would be all _six_ possible outcomes at the *same* time until you looked.

In Minecraft, imagine a block that is both diamond and coal.  Looking at that block will cause it to become one of the two, but you can't know which one until you look at it.

### Entanglement

Entanglement refers to the ability of pairs or groups of particles that are created together to have a special relationship: their states are related.  Not necessarilly the same state, but changing the state of one particle will have an effect on all its entangled partners.  What is incredible though, is that this change occurs instantaneously, regardless of the distance seperating the particles. This means that the particles can exchange information faster than the speed of light!

Some believe this principle could lead to breakthroughs in quantum *teleporatation*.

In Minecraft, imagine having an entangled pair of diamond/coal superposition blocks.  If we observe one of them and it is diamond, its partner, regardless of the distance seperating the two, will also be diamond.

Note: You can only entangle qCraft blocks.

## New Items

### Quantum ore/dust

1. Essence of Observation (EoO)  
2. Essence of Superposition (EoS)  
3. Essence of Entanglement (EoE)  
4. Automated Observer (AO)  
5. Quantum Computer

## Practical Uses

### Teleporter/Quantizer

qCraft introduces a new item called a "Quantum Computer" (QC) and it is mainly used to create a teleporter/quantizer.  
A quantizer will "digitize" a part of the Minecraft world which can then be copied (quantized) or transported (teleported). The only difference is that a teleporter recquires an *entangled pair of quantum computers*.

Items Needed:  

* Obsidian
* Full gold blocks
* Ice
* Glass blocks
* EoO
* Quantum Computer (optional entangled pair)

1. Craft 4 different Observational dependent blocks (ODB's) using Gold for one of the cardinal directions, and Obsidian for the rest.
2. Place these ODB's in a square/rectangle around a Quantum Computer (QC) such that all the ODB's resolve to Gold when you are standing in the enclosed area.  
3. Put a block of Ice next to the QC to provide cooling.
4. Place Obsidian blocks on top of the ODB's, as high as you want your teleportation area to be (These are called "Pylons").  
5. Then place a glass block on top of your Pylons.
6. Construct another area in exactly the same way and **SAME DIMENSIONS**
7. "Energize" the QC

Your teleporting Matrix should look like this:  

![An example of a teleporting matrix. \label{fig:telporterMatrix}](/images/Section_1/matrix.png)

Note: This will not transport you the player, only items/blocks inside the area.  **There is no distance cap!!!**

If you used entangled QC's then the contents of the two teleporters will be swapped.  If you chose to build a quantizer instead, break the Quantum computer and walk/run/swim/tp to the destination area, place the QC and activate it again.

Troubleshooting:  

1. The QC / pylon matrix dimensions don’t exactly match at origin and destination  
2. There is no room for quantized blocks at destination. (e.g. trying to move a tall tower to a mountaintop near the height limit of the world)  
3. Destination is abutting water or lava that could flow in and damage structures  
4. Source / destination contains blocks with extra info that would be lost in the transfer (e.g. blocks from other mods with unusual data storage methods) 

### Quantum Portal

If you were disappointed that the Teleporter didn't take you with the rest of your stuff, don't worry, qCraft has another great feature that will let you travel anywhere, including between servers.

You will need the same items for the portal as the teleporter/quantizer:  

* Obsidian
* Full gold blocks
* Ice
* Glass blocks
* EoO
* Quantum Computer

1. Create gold/obsidian ODB's such that they will resolve to Gold only when you try entering the Portal (so opposite cardinal directions, i.e. North and South)
2. Create the same structure as a nether portal only use the gold/obsidian ODB's for the corners and glass in between.
3. Place a quantum computer and a block of ice next to your portal

It will look like this  

![An example of a Quantum Portal. \label{fig:portal}](/images/Section_1/portal.png)

When you right-click the QC you will see this menu: 

![QP Menu. \label{fig:menu}](/images/Section_1/menu.png)

Name the Portal you have selected and give it a destination portal.
You will need to build at least two portals to get anywhere.

### Controlling Lighting in a (large) room

We are not limited to *entangling* merely two (2) objects together, we can in fact entangle a multitude together.  All you have to do is use one of the previously entangled blocks in the recipe. This allows us to have a mass number of objects react to a single action.  For example, I could entangle several superpositional redstone lamps together, and light them all at once simply by lighting one.
# Make an adventure map using the features of Minecraft

## Nifty Tricks

These are some ways in which you can use some of the cool properties of qCraft blocks to create a new, fascinating type of adventure map.

### Utilizing Invisibility

What you may not know, is that leaving one of the directional blocks empty when crafting ODB's or QB's will make them *invisible* and permeable from that direction or instance.  You can combine this with the properties of entangled groups to create trapdoors that activate upon entering a room, disappearing staircases, one way bridges, and hallways that weren't there a second ago.

### Portal loops

Think of an elevator to a building. Every portal you build is a door that elevator can stop at.  However, the floor you stop at will decide what your next stop will be.  You can use this to create a progression of portals to take players to different areas/levels.

#### Examples:

##### Fixed Path:

1. Portal 1 -> Portal 2  
1. Portal 2 -> Portal 1  

##### Progression  

1. Portal 1 -> Portal 2  
1. Portal 2 -> Portal 3  
1. Portal 3 -> Portal 4  
1. etc...  

##### Converging  

1. Portal 1 -> Portal 3  
1. Portal 2 -> Portal 3  
1. Portal 4 -> Portal 3  

### Implementing New Redstone: Automated Observer

qCraft features a new redstone item called an Automated Observer (AO).  An AO must be placed adjacent to the block it is observing.  The AO will only observe one block and will only do so as long as there is a redstone powering it.  You can combine this with logic gates and the invisibility property to make some interesting puzzles.

### New Items: Goggles

Another cool set of items in qCraft are goggles: Quantum and Anti-Observation  

Quantum Goggles: When worn, you will see all quantum blocks in their superpositional state (green and swirly).  This makes it relatively easy to differentiate quantum blocks from regular blocks and will also reveal invisible quantum blocks.

Anti-Observation Goggles: When worn, these goggles will make quantum blocks act as though your character wasn't there.  They will then resolve into their last observed state.  This can be used to work around or with ODB's and QB's without them constantly changing.
