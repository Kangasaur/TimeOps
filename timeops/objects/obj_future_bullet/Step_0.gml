/// @description 

if (place_meeting(x, y, obj_player))
{
	if (!instance_find(obj_player, 0).dodging)
	{
		global.player_health -= 2;
		instance_destroy();
	}
}
if (place_meeting(x, y, obj_wall)) instance_destroy();