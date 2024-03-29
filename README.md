# Fly Invastion
#### Video Demo:  https://youtu.be/38mswZkuGUs
#### Description: 
My final project presents itself in the form of a game made using the Lua programming language and the LÖVE framework. It's a shooter in which you have to survive as long as you can and reach the best score you can. Next I will explain what is the role of each file from the folder submitted. All the credits for the sprites and songs are in the credits.txt file.
## The main.lua File and love.draw()
This file is the "brain" of the game so to say. Everything starts and takes shape from the code contained here. The file stars with the love.load function, one of the three main functions provided by the LOVE framework that make life easier. This function is called once at the start of the program, with the role to load some one-time things in memory. The first part of the code is loading up the "classic" library and the "lume" library from their corresponding lua files. These libraries originate from the internet, all credit due there. Afterwards, my own lua files are loaded, presented later in the md. Next section loads the sound effects used in the game. The "screen" table saves important information about the screen for easier use in the future. The next lines creates the player object with the name "player". The next tables save the names of the sprites used, again for easier use down the road.

#### Tilemap
I made the level using a tilemap, a matrice in which the row dictates the height where the sprites in the column are placed. Each sprite was given a number earlier in the tables, 0 being empty space, number with one digits, representing grass textured platform, and number of 2 digits starting with 1 being background sprites. Using 2 "for" loops and the matrice, platform and background objects are being inserted in their respective tables, at their respective coorodonates. The numbers in the matrices that are not 0 are used as indexes to access the path for the image from the sprite tables.

#### Next
Two tables are created that will be used to store the Bullets shot and the Enemies that are alive. An enemy timer is set at 700 units, which means that the first enemy will spawn after around 7 seconds, giving the player enough time to read the controls. Afterwards there are 2 fish that swim around in the level, that are different from both enemies and platforms, which I have coded separately for my convenience. These go back and worth in the water sprites generated by the tilemap. The next few variables help with keeping time and adding score based on the time survived. The "if" function that follows checks if there exists a "savedata.txt" file in which the highscore from previous games exist, and gives that value to the "highscore" variable to appear on screen. This file is created and/or updated everytime the user achieves a new highscore.
Same as with the sprite tables, the powerup images table saves the images used for the powerup. The powerup duration and powerup spawn timer are saved in the next two variables, with the "k" value indicating to the rest of the file if there exists a powerup that HAS NOT yet been taken. "bulletDamage" dictates how much damage a bullet makes, "bulletColor" changes color of different sprites depending on the powerup, "multiplier" is the score multiplier, "reverse_check" tells the program if it should reset the powerup effects when the time comes and "cap" is the firing rate limit. The "dead_state" variable tells the program if the user is dead or not, and the "tips" variable is a timer which allows the tips to be shown as long as it is positive. When the player dies and "SPACE" is pressed, the program recalls the load function to restart the game.

#### In-between functions
In-between love.load and love.update there are three function, one of which tell us if a number is positive or not, another one saves the score, and the other creates a bullet when the left mouse button is clicked at the right coordonates, and playes the respective sound.

## Love.update(dt)
This function and the love.draw function are called one after another continuously as long as the game runs. In this function we clock down all the timers using the "dt" variable given as a parameter to the function, which holds the time in seconds since the last time the update function was called. The next two "if" functions have the role of dealing with the powerup spawn rate, duration, collision checking, giving effects and looping through these processes. In short, a powerup effect is chosen at random from the 4 available, each with a different sprite and effect, that when they come in contact with the player, give said effect to him and restart the timer. The next "if" function increases the score every second or so. The score additionally increases for every enemy killed. Next comes an "if" function that spawns enemies randomly at the top of the screen at random intervals between 1 and 3 seconds, with the exception being the first enemy of every run. The updating of each object takes place in this function as well, using a single line of code if the oject is one of a kind, like our player, or using "for" loops and going through the tables that contain them. The update functions do something different for every kind of objects, and we'll talk about them when their respective file comes to the spotlight. The next "for" loop does a lot of things:
- It updates each bullet that exist in the bullets table
- It removes bullets that go of screen or hit enemies or platforms as to not create lag
- It removes lives of an shot enemy
- It plays the respective sound when an enemy dies
The next "for" loop:
- Updates every enemy using the player's coordonates
- Check collision with the player of existing enemies and ends the game if they come in contact
The last "if" statements end the game if the player falls of the map or if the player comes in contact with an enemy, and deal with the back and forth movement of the fish.

## love.draw()
This function draws the sprite on the screen. It is called continuously after love.draw as long as the game runs. The first "if" prints the tips at the start of game that tell the player the controls. The score in the top right of the screen is printed next. It also updates the current x coordonates of the right and left part of the screen. The rest of the functions draws the objects as long as the player is alive. It also changes color of the things affected by a powerup when said powerup is picked up, and prints different messages when the player dies depending on the score.

#### love.keypressed()
This function listens to key pressed and depending on what key is pressed, it restarts the program (F5), makes the player jump (SPACE, W) or restarts the game if the player is dead. It also stops all audio when restarted.

## entity.lua
Entity.lua is a file used to create the entity class. This file is used to create every kind of object in my game. Every object from this class has x,y coords, an image, width and height of image, gravity and weight. The weight is for how fast said object falls, and the gravity variable is the acceleration. It also saves the previous x and y coords for solving collision. That's what the update function does in common for every object. Same goes for the entity:draw() functions. As long as they aren't overwritten, these instructions will be called if we update or draw an object. The collision functions are also a common factor for everybody. Using them we can find out if two objects collide based on their coords, from what side they come into contact, and we can solve said collision by going back to the last x and y coords or by increasing or decreasing the current x or y coords by the amount of pixels needed for them to be side by side again.

## conf.lua
It sets the game's window height and width, the name and the icon of the program.

## player.lua
The player object needs to be animated and controlled by the player. I have saved eleven different frames for the player in a table which are used in succesion if the player object is moving. It also has a 12th frame, used as long as the player's gravity is negative, which happens when the player jumps in the air. As long as the player is alive, the player:update(dt) function allows the player to move when the corresponding keys are pressed and allows jumping as long as the player is on the ground. What the Player:collide() function does extra is it checks the direction of collision using the functions from the entity.lua file and sets "gravity" for the player to 0 when their head bumps to a ceilling.

## bullet.lua
The bullet each use some complicated trigonometry and math formulas (not really) to go to the place where the mouse was clicked at. In rest it stays the same.

## enemy.lua
Each enemy has two possible sprite states, which change periodically to animate them. They also track the player and go to their location using not so complicated math. Both the enemies and the bullets calculate the tangent between their target and their position and increase their speed by multiplying their speed variable with the cosinus or sinus of the previously calculated tangent's angle.

## platform.lua
A kind of object with no weight that doesn't fall and it's drawn at half the scale for easier use.

## powerup.lua
A kind of object which is affected by gravity. The powerups are mostly coded in the main.lua file, here only being applied some minor restrictions, like a "gravity" limit and spawn restrictions.

## Other files
The "images" and "sounds" folders contain, you guessed it, the images and sounds used for the game, while the credits.txt file contains the credit for the aforementioned images and sounds.