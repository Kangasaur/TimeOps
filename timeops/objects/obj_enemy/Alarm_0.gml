/// @description Handles Jumping after the Player

jump_after = false;
chance = random_range(0, 100);
if(chance >= 50)
{
	y_speed = -jump_force;
	audio_play_sound(snd_alien_jump, 0, 0);
}

