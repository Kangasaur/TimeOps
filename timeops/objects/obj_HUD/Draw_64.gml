/// @description Insert description here
// You can write your code in this editor

//Health Bar
if(global.player_health < 0)
{
	global.player_health = 0;
}
var health_calc = global.player_max_health - global.player_health;
draw_sprite_ext(spr_Health_bar, health_calc, 64, 32, 2, 2, 0, c_white, 1);