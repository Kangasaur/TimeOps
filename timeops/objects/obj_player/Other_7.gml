/// @description Stop certain animations
switch(sprite_index)
{
	case spr_timeop_jump:
	case spr_timeop_fall:
		image_speed = 0;
		image_index = 1;
		break;
	case spr_timeop_crouch:
		image_speed = 0;
		image_index = 2;
		crouch_start = false;
		break;
	case spr_timeop_dodge:
		dodging = false;
		break;
}