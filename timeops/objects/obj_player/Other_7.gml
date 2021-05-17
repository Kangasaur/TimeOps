/// @description Stop certain animations

if (sprite_index == spr_timeop_jump || sprite_index == spr_timeop_fall)
{
	image_speed = 0;
	image_index = 1;
}
else if (sprite_index == spr_timeop_crouch)
{
	image_speed = 0;
	image_index = 2;
	crouch_start = false;
}