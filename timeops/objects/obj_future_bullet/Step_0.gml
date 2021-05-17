/// @description 

if (place_meeting(x, y, obj_player))
{
	global.player_health--;
	instance_destroy();
}
if (place_meeting(x, y, obj_wall)) instance_destroy();