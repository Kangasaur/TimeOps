/// @description Handles character actions and movement

//Movement

//Input
move_dir = 0;

//Time travel
if ((!jumping && keyboard_check(ord("F")) || travel_time >= 180))
{
	if (!place_meeting(x, y, obj_time_wall))
	{
		travelling = true;
		travel_time++;
		if (travel_time == 180) instance_create_depth(x, y+16, -500, obj_travel_flash);
		else if (travel_time == 220) room_goto(global.room_pairs[?room]);
	}
	else
	{
		//UI Message
		//"Current location obstructed in destination time"
	}
}
else
{
	travelling = false;
	travel_time = 0;
}

if (!travelling)
{
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
		if(!jumping)
		{
			jumping = true;
			y_speed = -jump_force;
		}
	}
}

//Gravity

y_speed += player_gravity;
if(y_speed > terminal_velocity)
{
	y_speed = terminal_velocity;
}

//Collision check and movement

for (var i = 0; i < abs(round(move_dir * move_speed)); i++)
{
	if (instance_place(x+move_dir, y, obj_wall)) break;
	else x += move_dir;
}

//Checking downward collisions
for (var i = 0; i < abs(round(y_speed)); i++)
{
	var collision = instance_place(x, y + sign(y_speed), obj_wall);
		
	if (collision != noone && !place_meeting(x, y, collision))
	{
		y_speed = 0;
		if (falling)
		{
			jumping = false;
			falling = false;
			image_index = 0;
			image_speed = 1;
		}
		break;
	}
	y += sign(y_speed);
}

//Animations
if (travelling)
{
	sprite_index = spr_timeop_travel;
	image_speed = 1;
}
else if (jumping && y_speed <= 0)
{
	sprite_index = spr_timeop_jump;
	if (move_dir != 0) image_xscale = move_dir;
}
else if (jumping && y_speed > 0)
{
	sprite_index = spr_timeop_fall;
	if (move_dir != 0) image_xscale = move_dir;
	if (!falling)
	{
		image_index = 0;
		image_speed = 1;
		falling = true;
	}
}
else if(move_dir != 0)
{
	image_xscale = move_dir;
	sprite_index = spr_timeop_walk;
}
else
{
	sprite_index = spr_timeop_idle;
}

//Camera controls

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
target_x = x - (camera_get_view_width(view_camera[0])/2);
target_y = y - 320;

camera_set_view_pos(view_camera[0], (cam_x * 0.95) + (target_x * 0.05), (cam_y * 0.95) + (target_y * 0.05));

//Global variables so everyone can keep track of the player
global.player_x = x;
global.player_y = y;