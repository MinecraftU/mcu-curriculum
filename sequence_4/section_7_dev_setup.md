## Setup

To get started writing mods, you'll need a good development environment. Always try to keep your enviromnet organized, since it's what you'll have to use to write all your code.
 
* To start off, start the download for [JetBrains IntelliJ IDEA Community Edition](http://www.jetbrains.com/idea/). Find the button towards the bottom of that page that says `Download Community`. This is a free version of their commercial IDE, and it has lots of the same features.

* While that's downloading, lets go grab [Forge](http://www.minecraftforge.net/forum/index.php?action=files), as it's what we need to develop mods. Pick the version marked `1.7.10` that's labeled as `Recommended`, and click the `*` next to `(Src)`. This should start downloading a file called something like `forge-1.7.10-10.13.0.1180-src.zip`

* Also download the [Java SDK](http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html). Download the correct version for your system from that page.

* We'll need a folder to do our development in. Make a folder called `minecraft` and another inside that called `dev`.

* The Java SDK should be done downloading. Install it by running the file you downloaded.

* IntelliJ should be finished downloading by now. Run the installer, and follow its instructions. Make sure you have installed the Java SDK before installing IntelliJ, it makes things easier.

* Once the Forge zip file is finished downloading, place it inside the `/minecraft/dev/` folder. Open it and there should be a folder labeled `forge` inside. Extract that to the `/minecraft/dev/` folder as well. This is the folder we will use to write your mod. Rename it to whatever you want your mod to be called. E.g. from `forge` to `DiamondCutter`. Keep the Forge zip file in case you need it later.

* Now we need to let Forge set itself up for development. Open the folder you just renamed. 

### Windows
* Hold shift and right click inside the folder you renamed. Click on `Open command window here`. Then type `gradlew setupDecompWorkspace --refresh-dependencies` and press `Enter`. This will download the Minecraft source code and decompile it so we can work with it to make our mod. 

* Open IntelliJ and select `import project`. Navigate to the folder you renamed and select `build.gradle`.

* Once IntelliJ finished importing the project, close it. Go back to your command window and type `gradlew genIntellijRuns`.

* Start IntelliJ and get to modding!

### Mac/Linux
* Open a terminal and navigate to the folder you just renamed. Type `./gradlew setupDecompWorkspace --refresh-dependencies` and press `Enter`. This will download the Minecraft source code and decompile it so we can work with it to make our mod. 

* Open IntelliJ and select `import project`. Navigate to the folder you renamed and select `build.gradle`.

* Once IntelliJ finished importing the project, close it. Go back to your terminal and type `./gradlew genIntellijRuns`.

* Start IntelliJ and get to modding!
