/// @description

if (place_meeting(x, y, obj_wall)) instance_destroy();
else if (place_meeting(x, y, obj_enemy))
{
	instance_destroy(instance_place(x, y, obj_enemy));
	global.enemies--;
	instance_destroy();
}