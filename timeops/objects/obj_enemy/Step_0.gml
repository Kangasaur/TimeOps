/// @description Handles Enemy AI and Movement

//Enemy Physics
y_speed += enemy_gravity;
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


//Jumping after the player
if(global.player_y < (y - 4) && jump_after == false && y_speed == 0)
{
	jump_after = true;
	alarm[0] = reaction_time * room_speed;
}

//Chasing the Player
move_dir = 0;
dist_to_player = distance_to_point(global.player_x, global.player_y);
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
	x = x + (move_dir * enemy_speed);	
}