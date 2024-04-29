///Player movement
if place_meeting(x,y,obj_corn)
{
	depth = -y;
	if !audio_is_playing(snd_corn)
	{
		audio_play_sound(snd_corn, 0, false, 8);
	}
}
else
{
	depth = 0;
	if audio_is_playing(snd_corn)
	{
		audio_stop_sound(snd_corn);
	}
}

//Get movement input
var _x_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _y_input = keyboard_check(ord("S")) - keyboard_check(ord("W"));
var _attack_input = keyboard_check_pressed(vk_space);

//Get velocity
move_x += _x_input * move_accel;
move_y += _y_input * move_accel;

//Brake if no input
if (_x_input == 0)
{
	if (move_x < 0) //add decel until stopped when moving left
	{
		move_x = min(move_x + move_decel, 0);
	}
	else // subtract decel until stopped when moving right
	{
		move_x = max (move_x - move_decel, 0);
	}
}

if (_y_input == 0)
{
	if (move_y < 0) //add decel until stopped when moving up
	{
		move_y = min(move_y + move_decel, 0);
	}
	else // subtract decel until stopped when down
	{
		move_y = max (move_y - move_decel, 0);
	}
}

//Set max velocity to movement speed
move_x = clamp(move_x, -move_speed, move_speed);
move_y = clamp(move_y, -move_speed, move_speed);

//determine collision
grounded = place_meeting(x, y+1, obj_collision);

var _x_collision = move_and_collide(move_x, 0, obj_collision, abs(move_x))

var _y_collision = move_and_collide(0, move_y, obj_collision, abs(move_y) + 1)

//Animation Controller
if move_x != 0
{
	image_xscale = -sign(move_x); //make the sprite face the x movement direction
}

switch (sprite_index) //handles cases for switching between animations
{
	#region idle
	case spr_pc_idle: //what happens when playing the idle animation
		image_speed = 1;
		if move_x != 0 || move_y != 0
		{
			sprite_index = spr_pc_run; //swap to run animation when moving and on ground
			image_index = 0; //reset frame count
			if audio_is_paused(snd_pc_walk)
			{
				audio_resume_sound(snd_pc_walk);
			}
			if !audio_is_paused(snd_pc_walk) && !audio_is_playing(snd_pc_walk)
			{
				audio_play_sound(snd_pc_walk, 0, true, 1, 1);
			}
		}
		
		if _attack_input == true
		{
			sprite_index = spr_pc_attack;
			image_index = 0; //reset frame
			attack = true;
			if !audio_is_playing(snd_pc_attack)
			{
				audio_play_sound(snd_pc_attack, 0, false);
			}
		}
		
		if _attack_input == true && distance_to_point(obj_alien.x, obj_alien.y) < 6
		{
			sprite_index = spr_pc_attack;
			image_index = 0; //reset frame
			attack = true;
			global.stun = true;
			if !audio_is_playing(snd_pc_attack)
			{
				audio_play_sound(snd_pc_attack, 0, false);
			}
		}
		
		if global.attack == true
		{
			sprite_index = spr_pc_recoil;
			image_index = 0; //reset frame
			move_x = 0;
			move_y = 0;
			global.health--;
			if !audio_is_playing(snd_pc_recoil)
			{
				audio_play_sound(snd_pc_recoil, 0, false);
			}
		}
		
		if global.health == 0
		{
			sprite_index = spr_pc_death;
			image_index = 0; //reset frame
			move_x = 0;
			move_y = 0;
		}
		break;
	#endregion
	#region run
	case spr_pc_run: //what happens when playing the run animation
		image_speed = 1;
		if _attack_input == true && distance_to_point(obj_alien.x, obj_alien.y) < 6
		{
			sprite_index = spr_pc_attack;
			image_index = 0; //reset frame
			attack = true;
			global.stun = true;
			if !audio_is_playing(snd_pc_attack)
			{
				audio_play_sound(snd_pc_attack, 0, false);
			}
		}
		
		if _attack_input == true 
		{
			sprite_index = spr_pc_attack;
			image_index = 0; //reset frame
			attack = true;
			if !audio_is_playing(snd_pc_attack)
			{
				audio_play_sound(snd_pc_attack, 0, false);
			}
		}
		
		if move_x == 0 && move_y == 0
		{
			sprite_index = spr_pc_idle;
			image_index = 0 //reset frame
			audio_pause_sound(snd_pc_walk);
		}
		break;
	#endregion
	#region attack
	case spr_pc_attack:
		image_speed = 1;
		if image_index == 3
		{
			sprite_index = spr_pc_idle; //swap to idle if animation finishes
			image_index = 0; //reset frame
			attack = false;
		}
		
		if move_x != 0 || move_y != 0
		{
			sprite_index = spr_pc_run; //swap to run animation when moving
			image_index = 0; //reset frame count
			if audio_is_paused(snd_pc_walk)
			{
				audio_resume_sound(snd_pc_walk);
			}
			if !audio_is_paused(snd_pc_walk) && !audio_is_playing(snd_pc_walk)
			{
				audio_play_sound(snd_pc_walk, 0, true, 1, 1);
			}
		}
	#endregion
	#region recoil
	case spr_pc_recoil:
		image_speed = 1;
		if image_index == 3
		{
			sprite_index = spr_pc_idle; //swap to idle if animation finishes
			image_index = 0; //reset frame
		}
		
		if move_x != 0 || move_y != 0
		{
			sprite_index = spr_pc_run; //swap to run animation when moving
			image_index = 0; //reset frame count
			if audio_is_paused(snd_pc_walk)
			{
				audio_resume_sound(snd_pc_walk);
			}
			if !audio_is_paused(snd_pc_walk) && !audio_is_playing(snd_pc_walk)
			{
				audio_play_sound(snd_pc_walk, 0, true, 1, 1);
			}
		}
		break;
	#endregion
	#region death
	case spr_pc_death:
		image_speed = 1;
		if image_index == 18
		{
			room_goto(rm_lose);
		}
		
		break;
	#endregion
	default:
		image_speed = 1;
		break;
}
