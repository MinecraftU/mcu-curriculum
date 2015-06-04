## Setup

###Downloads
To get started writing mods, you'll need a good development environment. Always try to keep your enviromnet organized, since it's what you'll have to use to write all your code.

* Download IntelliJ from their site: [JetBrains IntelliJ IDEA Community Edition](http://www.jetbrains.com/idea/). Find the button towards the bottom of that page that says `Download Community`. This is a free version of their commercial IDE, and it has lots of the same features.

* We'll also need to download [Forge](http://www.minecraftforge.net/forum/index.php?action=files), which is a modding API. In the section marked "Minecraft Versions" hover over "1.7" and select `1.7.10` from the drop down menu.  Down and to the right under "Download Recommended", click `Src`. Wait for the countdown on the top right, and click skip.  This should start downloading a file called `forge-1.7.10-10.13.#.####-src.zip`

* Also download the [Java SDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html). Download the correct version for your system from that page.

###Installation
1. Install the Java SDK by running the file you downloaded.

2. Run the IntelliJ installer, and follow its instructions. Make sure you have installed the Java SDK before installing IntelliJ, it makes things easier.

3. Make a new folder on the desktop and name it `Minecraft Dev` and drag the `forge` folder into it. The forge folder is a .zip file so we need to extract it (if you don't have an extraction tool we recommend 7-zip). Put the extracted folder into the Minecraft Dev folder. 

Note: If you wish, you can rename the extracted `forge` folder to whatever you want your mod to be called, e.g. from `forge` to `DiamondCutter`. Keep the Forge zip file in case you want to start a fresh mod.

### Getting Started for Windows
1. Hold shift and right click inside the folder you renamed. Click on `Open command window here`. Then type `gradlew setupDecompWorkspace --refresh-dependencies` and press `Enter`. This will download the Minecraft source code and decompile it so we can work with it to make our mod.

2. Once you get `BUILD SUCCESSFUL` type `gradlew idea` and press `Enter`.

3. After you get `BUILD SUCCESSFUL` again, run IntelliJ (the installation should have put a shortcut on your desktop).  You most likely won't have any setting to import (click `ok`).  Unless you have coding experience and have preferences, click `Skip All and Set Defaults`.

4. On the pop-up screen, select `Open` and navigate to the folder you renamed.

5. Find the file with the IntelliJ icon - it should be (Your_Folder_Name.ipr) and open it.

### Getting Started for Mac/Linux
1. Open a terminal and navigate to the folder you just renamed. Type `./gradlew setupDecompWorkspace --refresh-dependencies` and press `Enter`. This will download the Minecraft source code and decompile it so we can work with it to make our mod.

2. After you get `BUILD SUCCESSFUL` open IntelliJ and select `import project`. Navigate to the folder you renamed and select `build.gradle`.

3. Once IntelliJ finishes importing the project, close it. Go back to your terminal and type `./gradlew idea`.

4. Open IntelliJ back up and navigate back to your folder and import the file ending in `-src.ipr` 

### Testing

1. On the top left, double click the folder icon (the name of your folder should be next to it).

2. Double-click the folders: src > main > java > com.example.examplemod 

3. There should be an `ExampleMod` class (blue circle with the letter 'c' in it) and if you double-click it you should see the following code:

```java
package com.example.examplemod;

import net.minecraft.init.Blocks;
import cpw.mods.fml.common.Mod;
import cpw.mods.fml.common.Mod.EventHandler;
import cpw.mods.fml.common.event.FMLInitializationEvent;

@Mod(modid = ExampleMod.MODID, version = ExampleMod.VERSION)
public class ExampleMod
{
    public static final String MODID = "examplemod";
    public static final String VERSION = "1.0";

    @EventHandler
    public void init(FMLInitializationEvent event)
    {
		// some example code
        System.out.println("DIRT BLOCK >> "+Blocks.dirt.getUnlocalizedName());
    }
}
```
* Left-click on _ExampleMod_ and press `Shift + F6` Change the name to something that you like and click `Refactor`. For our examples, we use `CopperMod` since our mod adds copper to the game. We'll also have to change the _MODID_ and _VERSION_ to what we want. You can delete the example `println` statement if you wish.
