/// @description Initialize global variables, etc.

global.player_x = -1000; //player position initialized to a value the game will never use
global.player_y = -1000;

global.room_pairs = ds_map_create(); //initialize room pairs
ds_map_add(global.room_pairs, Start_Past, Start_Future);
ds_map_add(global.room_pairs, Start_Future, Start_Past);

room_goto(Start_Past);