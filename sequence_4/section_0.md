## Setup

### Downloads

To get started writing mods, you'll need a good development environment. Always try to keep your enviromnet organized, since it's what you'll have to use to write all your code.

* Download IntelliJ from their site: [JetBrains IntelliJ IDEA Community Edition](http://www.jetbrains.com/idea/). Find the button towards the bottom of that page that says `Download Community`. This is a free version of their commercial IDE, and it has lots of the same features.

* We'll also need to download [Forge](http://www.minecraftforge.net/forum/index.php?action=files), which is a modding API. In the section marked "Minecraft Versions" hover over "1.7" and select `1.7.10` from the drop down menu.  Down and to the right under "Download Recommended", click `Src`. Wait for the countdown on the top right, and click skip.  This should start downloading a file called `forge-1.7.10-10.13.#.####-src.zip`

* Also download the [Java SDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html). Download the correct version for your system from that page.

### Installation

1. Install the Java SDK by running the file you downloaded.

2. Run the IntelliJ installer, and follow its instructions. Make sure you have installed the Java SDK before installing IntelliJ, it makes things easier.

3. Make a new folder on the desktop and name it `Minecraft Dev` and drag the `forge` folder into it. The forge folder is a .zip file so we need to extract it (if you don't have an extraction tool we recommend 7-zip). Put the extracted folder into the Minecraft Dev folder.

Note: If you wish, you can rename the extracted `forge` folder to whatever you want your mod to be called, e.g. from `forge` to `DiamondCutter`. Keep the Forge zip file in case you want to start a fresh mod.

### Getting started for Windows

1. Hold shift and right click inside the folder you renamed. Click on `Open command window here`. Then type `gradlew setupDecompWorkspace --refresh-dependencies` and press `Enter`. This will download the Minecraft source code and decompile it so we can work with it to make our mod.

2. Once you get `BUILD SUCCESSFUL` type `gradlew idea` and press `Enter`.

3. After you get `BUILD SUCCESSFUL` again, run IntelliJ (the installation should have put a shortcut on your desktop).  You most likely won't have any setting to import (click `ok`).  Unless you have coding experience and have preferences, click `Skip All and Set Defaults`.

4. On the pop-up screen, select `Open` and navigate to the folder you renamed.

5. Find the file with the IntelliJ icon - it should be (Your_Folder_Name.ipr) and open it.

### For MAC

1. Double-click the zipped forge  
2. Drag the forge folder that is created to your desktop  
3. Download gradle: https://gradle.org/gradle-download/  
    - click the Binary only distribution (second option)  
4. Unzip it and put it in the forge folder on your desktop  
5. Then press command+spacebar and type in "terminal" and press Enter (this will open a terminal window)  
6. Type "cd Desktop" and press Enter  
7. Type "cd forge" and press Tab (it should auto-complete to the folder name) and then press Enter  
8. Type "./gradle-2.5/bin/gradle setupDecompWorkspace --refresh-dependencies" and press Enter
9. After BUILD SUCCESSFUL shows up type: "./gradle-2.5/bin/gradle idea"

### Troubleshooting:

The most common error is the build failing with a message saying "JAVA_HOME does not point to JDK":

1. Click start  
2. Right-click Computer  (for Windows 8 open up file explorer and right-click "This PC")  
3. Click properties  
4. On the left side click advanced system settings  
5. At the bottom of the pop-up, click Environment Variables  
6. Under system variables (second section of pop-up) click new  
7. Name it JAVA_HOME  
8. The value should point to your JDK 7 folder (something like "C:\Program Files\Java\jdk1.7.0_51")  
9. Click ok  
10. Close and re-open command prompt and run the command again.  

### Testing

1. On the top left, double click the folder icon (the name of your folder should be next to it).

2. Double-click the folders: src > main > java > com.example.examplemod

3. There should be an `ExampleMod` class (blue circle with the letter 'c' in it) and if you double-click it you should see the following code (you might have to change `preInit` to `init` and `FMLPreInitializationEvent` to `FMLInitializationEvent`):
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

4. Left-click on `ExampleMod` and press `Shift + F6`. Change the name to something that you like and click `Refactor`. This will change all instances of `ExampleMod` to a mod name of your choice. For our examples, we use `CopperMod` since our mod adds copper to the game. We'll also have to change the `MODID` and `VERSION` to what we want. You can delete the example `println` statement if you wish.

5. If this is your first IntelliJ project, or you don't have an SDK setup, you will need to do so now. 
    * Press `ctrl + shift + alt + s` 
    * In the `Project SDK` section click `New...` and click `JDK`
    * A _Select Home Directory for JDK_ window will appear.  Navigate to your `Java` folder which by default should be in `C:\ > Program Files > Java`  Click the jdk folder and hit `OK`  
![JDK Directory](images/section_0/jdk_directory.png)

###Publishing your mod

Running the command `gradlew build` or `gradle build` will package your mod into a .JAR file in the build/libs folder.  You can then add it to Minecraft like any other mod.
