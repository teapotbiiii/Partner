//show hold E text
if point_distance(x,y,obj_player.x,obj_player.y)>300
	{
		show_text = false;
	}

//When to show Activated text
if point_distance(x,y,obj_player.x,obj_player.y)<=300
{
	show_text = true
    if keyboard_check_pressed(ord("E"))
	{
		audio_play_sound(snd_jammer, 0, false);
	}
	if keyboard_check(ord("E"))
	{
        jammer_timer += 1/room_speed;
		
		show_progress = true;
		progress += progress_speed;
		if jammer_timer = 5
		{
			show_progress = false;
			progress = progress_max;
			jammer_switch = true;
			global.jammer_counter = global.jammer_counter + 1;
			audio_play_sound(snd_activated, 0, false);
		}
	}
	
	if jammer_switch == true
	{
		show_text = false;
	}
	
	if keyboard_check_released(ord("E"))
	{
		jammer_timer = 0;
		audio_stop_sound(snd_jammer);
	}
}