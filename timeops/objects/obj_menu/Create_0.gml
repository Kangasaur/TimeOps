/// @description Initialize global variables, etc.

randomize();

global.player_x = -1000; //player position initialized to a value the game will never use
global.player_y = -1000;

global.room_pairs = ds_map_create(); //initialize room pairs
ds_map_add(global.room_pairs, Start_Past, Outside_Future);
ds_map_add(global.room_pairs, Outside_Future, Start_Past);

room_goto(Start_Past);