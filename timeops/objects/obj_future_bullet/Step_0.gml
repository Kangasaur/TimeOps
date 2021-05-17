/// @description 

if (place_meeting(x, y, obj_player))
{
	global.player_health--;
}
if (place_meeting(x, y, obj_wall)) instance_destroy();