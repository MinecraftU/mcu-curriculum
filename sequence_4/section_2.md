# Make an adventure map using the features of Minecraft

## Nifty Tricks

These are some ways in which you can use some of the cool properties of qCraft blocks to create a new, fascinating type of adventure map.

### Utilizing Invisibility

What you may not know, is that leaving one of the directional blocks empty when crafting ODB's or QB's will make them *invisible* and permeable from that direction or instance.  You can combine this with the properties of entangled groups to create trapdoors that activate upon entering a room, disappearing staircases, one way bridges, and hallways that weren't there a second ago.

### Portal loops

Think of an elevator to a building. Every portal you build is a door that elevator can stop at.  However, the floor you stop at will decide what your next stop will be.  You can use this to create a progression of portals to take players to different areas/levels.

#### Examples:

Fixed Path:  
1. Portal 1 -> Portal 2  
1. Portal 2 -> Portal 1  

Progression  
1. Portal 1 -> Portal 2  
1. Portal 2 -> Portal 3  
1. Portal 3 -> Portal 4  
1. etc...  

Converging  
1. Portal 1 -> Portal 3  
1. Portal 2 -> Portal 3  
1. Portal 4 -> Portal 3  

### Implementing New Redstone: Automated Observer

qCraft features a new redstone item called an Automated Observer (AO).  An AO must be placed adjacent to the block it is observing.  The AO will only observe one block and will only do so as long as there is a redstone powering it.  You can combine this with logic gates and the invisibility property to make some interesting puzzles.

### New Items: Goggles

Another cool set of items in qCraft are goggles: Quantum and Anti-Observation  

Quantum Goggles: When worn, you will see all quantum blocks in their superpositional state (green and swirly).  This makes it relatively easy to differentiate quantum blocks from regular blocks and will also reveal invisible quantum blocks.

Anti-Observation Goggles: When worn, these goggles will make quantum blocks act as though your character wasn't there.  They will then resolve into their last observed state.  This can be used to work around or with ODB's and QB's without them constantly changing.

### Entanglement  Explained
If you tried being creative, you're mostly likely all tangled up trying to entangle things.  Heh.  Not to worry, this should help you become _untangled_. Okay, enough jokes.

1. You can ony entangle ODB/quantum blocks.  
2. You can make quantum blocks and ODB's with the same block from all sides.
3. Quantum blocks made from multiple types of blocks will change properties based on what state they resolve to.
4. Large entangled groups are made by entangling a new ODB with an ODB already in the entangled group.
5. You cannot un-entangle anything (without destroying it).
6. Entangled superpositional blocks will all resolve to the same block, making them more dependable than ODB's in large groups.
