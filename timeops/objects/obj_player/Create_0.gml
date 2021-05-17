/// @description Sets up variables


//Controls start position
if (global.player_x == -1000 && global.player_y == -1000)
{
	global.player_x = x;
	global.player_y = y;
}
else
{
	x = global.player_x;
	y = global.player_y;
}

y_speed = 0;
x_speed = 0;
remainder = 0;
jumping = false;
falling = false;
travelling = false;
travel_time = 0;
crouching = false;
crouch_start = false;
dodging = false;
dodge_x = 0;
knifing = false;

gun = instance_create_depth(x, y-18, -10, obj_gun_past);
knife = 0;
shot_angle = 0;

cam_x = 0;
cam_y = 0;
target_x = 0;
target_y = 0;
camera_set_view_pos(view_camera[0], x - (camera_get_view_width(view_camera[0])/2), y - 320);

global.player_max_health = 10;
global.player_health = 5;