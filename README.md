# csc258-Volcano-scientific-drome-operation

## One sentence description of our project:  
A game on the monitor of controlling planes to avoid obstacles such as the lava and the mountains by using the switches on KEYs and switches on the De1-soC board.

## Top Level Module name: Top_Level_Game in Top_Level_Game.v

## Project Design
state the name of each module in your project and a one-sentence description of what function it performs. Add any additional statements as required to explain how the different modules work with each other (data dependencies, master-slave relationship etc.)
list the Verilog modules were not created by you: VGA adapter, keyboard etc.
state the resources (and their URLs) that you used to create the project and their role/use. For example:
abc GitHub repo - basic source code for the player avatar display
xyz uni project page - main idea for the game
pqr stackexchange page - working solution to troubleshoot the speaker's buzzing issue  
1. VGA_Controller.v->generate the active-low signals VGA-HS, VGA-VS by using the implementation introduced in MIT.  
(reference: http://web.mit.edu/6.111/www/s2004/NEWKIT/vga.shtml)  
2. Controller.v-> draw the current scene of the game given the coordinates of each object (the coordinates represent the top left corner of each object).  
3. draw.v -> draw objects in the game including lava(represented by a red 16\times16 square), 2 mountains(represented by 2 green rectangles with width of 50 and randomly generated heights), plane(represented by a blue 16\times16 square)  
There are multiple small modules in this file:  

| module | description |  
| -------- | ----------- |  
| plane   | 16x16 blue square that represents a plane |  
| lava    | 16x16 red square that represents a lava. If a plane hits a lava, then 1 life would be deducted. |  
| moutain | 50xrandom height green rectangles that represents 2 mountains. If a plane hits a mountain, then 1 life would be deducted. |  
| random_generator| Linear feedback shifter to generate 4 bits number to control the height of mountain. |  
| random_generator_nine_bits| Linear feedback shifter to generate 9 bits number to shine up LEDR's |  

4. check_crash.v -> Use the coordinates of the plane and the obstacles to figure out whether they crash or not. Note that, when the plane just crashes with the lava, it will only lose 1 life. But when crash with the mountain, it will lose all its lives and the game is over immediately.  
5. SpeedController.v-> SW[0] control the rate of screen rolling and the gap’s width for lava drop coming out 
6. ScoreDisplay.v -> track current player’s score, increment every time that the player avoid crashing with a lava or a mountain.  
7. VGAFrequency.v ->change the frequency of the vgaclk to 25MHZ to slow down the frequency of the VGA-display  
8. Top_Level_Game.v -> The overall top level design for integration of all modules.
9. components.v -> Hex light controller to indicate the life remaining for the player on HEX5. Initially it would be 3.  

## Master-slave relationship
Top_Level_Game  
..* Hex  
..* VGA_Controller  
...* Controller  
....* plane, lava, mountain  
..* check_crash  
