# SPACE POTATOES
#### Video Demo:  <URL HERE>
#### Description:

##### General Concept: Space potatoes is a videogame made with Lua and Love 2d about explosive potatoes that rule the galaxy. You are a Killing potato space trooper that has to destroy as many potatoes as you can. The game is a 2D space shooter inspired by games like asteroids. I did it as a final project for CS50 course.

##### Game scope: The game has only one level in which you have to destroy as many potatoes as you can. You have 3 lives and you lose one of them as soon as a potatoe touches you. Potatos appear randomly from different sides of the screen, with different size and speed, they can collide between them and change their trayectory. I included some background story in the start game menu and some music I had composed some years ago. I didin´t get to implement power ups and enemies with different behaviours, it would be nice to do it in the future but I decided to stop and show the game such as it is.

##### Files: Generally speaking the project is divided in Assets (images, sound effects and music), .lua files for different objects in the game (player, planets, potatoes, etc), .lua states files for different parts of the game (Title Menu, gameplay, GameOver menu), some .lua files to use features like classes made by other people and a main file to rule them all.

###### main.lua contains the logic for how the game moves between its different states, you can fin the implementatios of the game state machine in this file. It also has the lines of code that allow functionality of the keys in the keyboard that makes the game work.

###### States folder includes Menu.lua, GameOver.Lua and Game.Lua. The first two are simple files that include some text and some functionality to scroll the story and credits. Game.lua has all the basics for the gameplay itself. This is: updates and renders all the objects of the game, check for collisions, destroys objects that collided or are outside of the screen (I used tables to implement this), make the player lose lives and end the game. It also has all the logic to make the background scroll infinitely, planets and stars are randomly generated with different size and chosen between 12 planets, where and when they appear is also random and I made it so that you can´t see the same planet on screen more than one time.

###### Player, Asteroid, Bullet, Planet, CellestialObject, Explosion and LoseLife have all the definition of those gameobjects or classes with methods to initialize them with some properties, methods to update and render and some other methods in some cases. In Player, Bullets and Asteroids you can add code to draw the colliders in case you want to check them out (Code is actually commented). In player you have also the functionality to move the player.

######  Class.lua is a code made by other person to use class functionality in lua. Push.lua also has some functionality made by some other person to render the game. Credits are in those files-

###### In helpers.lua file you can find some additional functions that I needed. The most important is the collision function. In fact, there are 3 collision functions, one to manage collisions between asteroid, one to manage collisions between asteroid and the player and one to manage collisions between asteroids and bullets. I had to implement 3 of the way I rendered each object. Also, as I implemented all rectangular colliders, I had to take in consideration the size of each image and from where I rendered it. For example, the player was rendered from the center of the image because I found it was the best way to make moving animations fluid. Bullets where drawn from left-top corner and as they where rotated the collider changed. All this things made me do 3 different collision checking functions. 

###### In the other folder you can find the game assets. In sounds you can find music and sound effects, yo can check for credits in the in-game credits. In fonts you can find some fonts used in the game and, in the rest of the folders, you can find image files used for the game.

##### Thanks to: My wife and cat for the support, CS50 for a great course and teachings, GD50 for an introduction to LUA, sheepolution for a crash course on LUA.