/// @description Handles character actions and movement

//Movement

//Input
move_dir = 0;

shot_angle = point_direction(gun.x, gun.y, mouse_x, mouse_y);

//Time travel
if ((!jumping && keyboard_check(ord("F")) || travel_time >= 180))
{
	object_set_visible(gun, false);
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
	object_set_visible(gun, true);
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
	if((keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_space)) && !jumping)
	{
		jumping = true;
		y_speed = -jump_force;
		image_speed = 1;
		image_index = 0;
	}
	if (!jumping && keyboard_check(ord("S")))
	{
		if (!crouching)
		{
			crouching = true;
			crouch_start = true;
		}
	}
	else crouching = false;
	if (mouse_check_button_pressed(mb_left))
	{
		var create_height;
		if (crouching) create_height = y - 10;
		else create_height = y - 18;
		var bullet = instance_create_depth(x + (move_dir * move_speed), create_height, -100, obj_past_bullet);
		bullet.image_angle = shot_angle + random_range(-6, 6);
		bullet.direction = bullet.image_angle;
		bullet.speed = 10;
	}
}

//Gravity

y_speed += player_gravity;
if(y_speed > terminal_velocity)
{
	y_speed = terminal_velocity;
}

//Collision check and movement
if (crouching) x_speed = crawl_speed;
else x_speed = move_speed;
remainder += x_speed - floor(x_speed);
if (remainder > 1)
{
	x_speed += 1;
	remainder -= 1;
}
for (var i = 0; i < floor(abs(move_dir * x_speed)); i++)
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
	if (crouch_start) sprite_index = spr_timeop_crouch;
	else if (crouching)
	{
		image_speed = 1;
		sprite_index = spr_timeop_crawl;
	}
	else
	{
		image_speed = 1;
		sprite_index = spr_timeop_walk;
	}
}
else
{
	if (crouching) sprite_index = spr_timeop_crouch;
	else sprite_index = spr_timeop_idle;
}


if (image_xscale = 1) gun.image_angle = shot_angle;
else gun.image_angle = 90 - (shot_angle - 90);
if (gun.image_angle > 180) gun.image_angle = clamp(gun.image_angle, 280, 360);
else gun.image_angle = clamp(gun.image_angle, 0, 80);
if (crouching)
{
	gun.x = x + (4 * image_xscale);
	gun.y = y - 10;
}
else
{
	gun.x = x + (2 * image_xscale);
	gun.y = y - 18;
}

gun.image_angle *= image_xscale;
gun.image_xscale = image_xscale;

//Camera controls

cam_x = camera_get_view_x(view_camera[0]);
cam_y = camera_get_view_y(view_camera[0]);
target_x = x - (camera_get_view_width(view_camera[0])/2);
target_y = y - 320;

camera_set_view_pos(view_camera[0], (cam_x * 0.95) + (target_x * 0.05), (cam_y * 0.95) + (target_y * 0.05));

layer_x(layer_get_id("Background_Insts"), camera_get_view_x(view_camera[0]) + 288); //A temporary solution


//Global variables so everyone can keep track of the player
global.player_x = x;
global.player_y = y;