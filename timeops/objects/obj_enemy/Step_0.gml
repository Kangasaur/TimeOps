/// @description Handles Enemy AI and Movement

y_speed += enemy_gravity;
if(y_speed > terminal_velocity)
{
	y_speed = terminal_velocity;
}

//Collision check and movement

//Checking downward collisions
for (var i = 0; i < abs(round(y_speed)); i++)
{
	var collision = instance_place(x, y + sign(y_speed), obj_wall);
		
	if (collision != noone && !place_meeting(x, y, collision))
	{
		y_speed = 0;
		break;
	}
	y += sign(y_speed);
}

//Jumping after the player
if(global.player_y < (y - 4) && jump_after == false && y_speed == 0)
{
	jump_after = true;
	alarm[0] = reaction_time * room_speed;
}

//Chasing the Player
move_dir = 0;
dist_to_player = distance_to_point(global.player_x, global.player_y);
if (dist_to_player < shot_distance)
{
	shot_time--;
	image_xscale = sign(global.player_x - x);
	shot_angle = point_direction(x, y, global.player_x, global.player_y);
	if (shot_time == 0)
	{
		var bullet = instance_create_depth(x + (8 * image_xscale), y - 10, -10, obj_future_bullet);
		bullet.direction = shot_angle;
		bullet.speed = 6;
		shot_time = irandom_range(40, 150);
	}
}
if(dist_to_player < chase_distance)
{
	if(global.player_x < x)
	{
		move_dir = -1;
	}
	else
	{
		move_dir = 1;
	}
	image_xscale = move_dir;
	if(dist_to_player < attack_distance)
	{
		move_dir = 0;
	}
	for (var i = 0; i < abs(round(move_dir * enemy_speed)); i++)
	{
		if (instance_place(x+move_dir, y, obj_wall)) break;
		else x += move_dir;
	}	
}