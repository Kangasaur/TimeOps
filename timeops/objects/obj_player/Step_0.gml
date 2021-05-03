/// @description Handles character actions and movement

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
if(y >= room_height && y_speed > 0)
{
	y = room_height;
	y_speed = 0;
	jumping = false;
}

y = y + (y_speed);
//Animations
if(move_dir != 0)
{
	image_xscale = move_dir;
	sprite_index = spr_timeop_walk;
}
else
{
	sprite_index = spr_timeop_idle;
}
