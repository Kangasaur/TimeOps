/// @description Handles character actions and movement

//Global variables so everyone can keep track of the player
global.player_x = x;
global.player_y = y;

//Movement
//Input
move_dir = 0;
if(keyboard_check(ord("A")))
{
	move_dir = -1;
}
if(keyboard_check(ord("D")))
{
	move_dir = 1;
}
if(keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_space))
{
	if(jumping == false)
	{
		jumping = true;
		y_speed = -jump_force;
	}
}

//Moves the Player
x = x + (move_dir * move_speed);

y_speed += player_gravity;
if(y_speed > terminal_velocity)
{
	y_speed = terminal_velocity;
}
if(y >= room_height - ground_height && y_speed > 0)
{
	y = room_height - ground_height;
	y_speed = 0;
	jumping = false;
}

y = y + (y_speed);

//Animations
if (jumping && y_speed <= 0)
{
	sprite_index = spr_timeop_jump;
}
else if (jumping && y_speed > 0)
{
	sprite_index = spr_timeop_fall;
}
else if(move_dir != 0)
{
	image_xscale = move_dir;
	sprite_index = spr_timeop_walk;
	image_speed = 1
}
else
{
	sprite_index = spr_timeop_idle;
	image_speed = 1
}

//Camera controls

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
target_x = x - (camera_get_view_width(view_camera[0])/2) + (128 * image_xscale);
target_y = y - 320;

camera_set_view_pos(view_camera[0], (cam_x * 0.95) + (target_x * 0.05), (cam_y * 0.95) + (target_y * 0.05));