if place_meeting(x,y,obj_corn)
{
	depth = -y;
}
else
{
	depth = -1;
}

//seek target
if point_distance(x,y,obj_player.x,obj_player.y)>1500
{
    speed = 0;
    if !place_meeting(x + move_x, y, obj_collision) && !place_meeting(x, y + move_y, obj_collision)
	{
        x += move_x;
        y += move_y;
    }
    else if place_meeting(x + move_x, y, obj_collision) || place_meeting(x, y + move_y, obj_collision)
	{
        move_x = random_range(-5,5);
        move_y = random_range(-5,5);
    }
}

//target spotted
if point_distance(x,y,obj_player.x,obj_player.y)<=1500
{
	move_towards_point(obj_player.x,obj_player.y,12);
	if !audio_is_playing(snd_al_approach)
	{
		audio_play_sound_at(snd_al_approach, obj_alien.x, obj_alien.y, 0, 100, 300, 1, false, 1);
	}
	if global.stun == true
	{
		speed = 0
	}
} 

//stop him
if distance_to_point(obj_player.x, obj_player.y) < 2
{
	speed = 0;
	attack = true;
}

//face x direction
if x - obj_player.x > 0
{
	image_xscale = 1;
}
else if x - obj_player.x < 0
{
	image_xscale = -1;
}

if cooldown <= 8 && cooldown > 0
{
	cooldown -= cooldown_speed;
}

if stun_timer <= 5 && stun_timer > 0
{
	stun_timer -= 1/room_speed;
}
		
//Animation Controller
switch (sprite_index) //handles cases for switching between animations
{
	#region run
	case spr_al_run: //what happens when playing the idle animation
		image_speed = 1;
		if attack == true && cooldown == 0
		{
			sprite_index = spr_al_attack;
			image_index = 0; //reset frame
			global.attack = true;
			if !audio_is_playing(snd_al_attack)
			{
				audio_play_sound(snd_al_attack, 0, false);
			}
		}
		if global.stun == true
		{
			sprite_index = spr_al_recoil;
			image_index = 0; //reset frame
			stun_timer = 5;
			speed = 0;
			if !audio_is_playing(snd_al_recoil)
			{
				audio_play_sound(snd_al_recoil, 0, false);
			}
		}
		break;
	#endregion
	#region attack
	case spr_al_attack:
		image_speed = 1;
		if image_index == 6
		{
			sprite_index = spr_al_run; //swap to idle if animation finishes
			image_index = 0; //reset frame
			attack = false;
			global.attack = false;
			cooldown = 8;
			audio_stop_sound(snd_al_attack);
		}
		break;
	#endregion
	#region recoil
	case spr_al_recoil:
		image_speed = 1;
		if stun_timer == 0
		{
			sprite_index = spr_al_run; //swap to idle if animation finishes
			image_index = 0; //reset frame
			global.stun = false;
			audio_stop_sound(snd_al_recoil);
		}
		break;
	#endregion
	default:
		image_speed = 1;
		break;
}

/*image_speed = 1;
if zoom_x > 0 
{
	sprite_index = spr_al_run;
	image_xscale = -1;
}
else if zoom_x < 0 
{
	sprite_index = spr_al_run;
	image_xscale = 1;
}
else if zoom_y > 0 
{
	sprite_index = spr_al_run;
}
else if zoom_y < 0 
{
	sprite_index = spr_al_run;
}
else if attack == true
{
	sprite_index = spr_al_attack;
}