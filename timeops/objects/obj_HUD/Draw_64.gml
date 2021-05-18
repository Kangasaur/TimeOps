/// @description Insert description here
// You can write your code in this editor

//Health Bar
if(global.player_health < 0)
{
	global.player_health = 0;
}
var health_calc = global.player_max_health - global.player_health;
if (global.player_health == 0) room_goto(Gameover);
draw_sprite_ext(spr_Health_bar, health_calc, 64, 32, 2, 2, 0, c_white, 1);

if (global.tutorial)
{
	if (global.player_x < 732) global.travel_message = "WASD to move";
	else if (global.player_x < 920) global.travel_message = "Shift to dodge";
	else if (instance_exists(obj_healthpack)) global.travel_message = "E to pick up";
	else if (global.player_x < 1136) global.travel_message = "LMB to shoot, RMB to use knife";
	else if (global.tut_message == 10) global.travel_message = "Hold F to time travel";
}


draw_set_font(ft_semi_square);
draw_set_halign(fa_left);
draw_text(64, 80, "Health: " + string(global.player_health / 2));
draw_text(64, 108, "Ammo: " + string(global.player_ammo));
draw_set_halign(fa_center);
draw_text(683, 200, global.travel_message);

if (global.screen)
{
	draw_sprite_ext(spr_white_pixel, 0, 0, 0, 1366, 768, 0, c_black, 0.75);
	var msg;
	if (global.tutorial && global.tut_message < 10)
	{
		switch(global.tut_message)
		{
			case 0:
				msg = "1 new message from Col. Edwards.";
				break;
			case 1:
				msg = "Congratulations on your new promotion, Miles."
				break;
			case 2:
				msg = "As a TimeOp, your mission is to travel to the future\nto gain insight into weapons and tactics.";
				break;
			case 3:
				msg = "You have been issued a wrist-carried time travel device.";
				break;
			case 4:
				msg = "You can use this to travel between the future and present at any time,\nalthough be aware that it takes a few seconds to charge up.";
				break;
			case 5:
				msg = "The particular future you're travelling to has been overrun by aliens.";
				break;
			case 6:
				msg = "You will be collecting data automatically. After you've defeated\na certain number of enemies, report back here to complete your mission.";
				break;
			case 7:
				msg = "It's dangerous out there, but don't worry.\nWe've left additional health and ammo supplies in the nearby buildings."
				break;
			case 8:
				msg = "Good luck, operative.";
				break;
			case 9:
				msg = "End of message.";
				break;
		}
		if (keyboard_check_pressed(ord("E")))
		{
			global.tut_message++;
			if (global.tut_message == 10) global.screen = false;
		}
	}
	else if (global.enemies > 0)
	{
		msg = "Insufficient data. " + string(global.enemies) + " enemies remain.";
		if (keyboard_check_pressed(ord("E"))) global.screen = false;
	}
	else
	{
		msg = "Data collected. Thank you for your valuable\ncontribution to our combat knowledge.";
		if (keyboard_check_pressed(ord("E"))) room_goto(End_UI);
	}
	
	draw_text(683, 384, msg);
	draw_text(683, 500, "E to continue");
}