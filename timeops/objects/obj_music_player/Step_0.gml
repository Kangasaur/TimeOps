if (!audio_is_playing(snd_music_start))
{
	audio_play_sound(snd_music_loop, 0, 1);
	instance_destroy();
}