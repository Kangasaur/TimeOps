/// @description Initialize global variables, etc.

randomize();

global.player_x = -1000; //player position initialized to a value the game will never use
global.player_y = -1000;
global.player_max_health = 10;
global.player_health = 10;
global.player_ammo = 0;
global.enemies = 18;

global.room_pairs = ds_map_create(); //initialize room pairs
ds_map_add(global.room_pairs, Start_Past, Start_Future);
ds_map_add(global.room_pairs, Start_Future, Start_Past);
ds_map_add(global.room_pairs, Outside_Past, Outside_Future);
ds_map_add(global.room_pairs, Outside_Future, Outside_Past);

global.travel_message = "";
global.tutorial = true;
global.tut_message = 0;
global.screen = false;
audio_play_sound(snd_ambience, 0, 1);