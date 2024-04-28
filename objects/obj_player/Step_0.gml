///Player movement
if place_meeting(x,y,obj_corn)
{
	depth = -y;
}
else
{
	depth = 0;
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

if cooldown <= 5 && cooldown > 0
{
	cooldown -= cooldown_speed;
}

switch (sprite_index) //handles cases for switching between animations
{
	#region idle
	case spr_pc_idle: //what happens when playing the idle animation
		image_speed = 1;
		if move_x != 0
		{
			sprite_index = spr_pc_run; //swap to run animation when moving and on ground
			image_index = 0; //reset frame count
		}
	
		if move_y != 0
		{
			sprite_index = spr_pc_run; 
			image_index = 0; //reset frame count
		}
		
		if _attack_input == true && cooldown == 0
		{
			sprite_index = spr_pc_attack;
			image_index = 0; //reset frame
			attack = true;
			global.stun = true;
		}
		
		if global.attack == true
		{
			sprite_index = spr_pc_recoil;
			image_index = 0; //reset frame
			move_x = 0;
			move_y = 0;
			global.health--;
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
		if _attack_input == true && cooldown == 0
		{
			sprite_index = spr_pc_attack;
			image_index = 0; //reset frame
			attack = true;
			global.stun = true;
		}
		
		if move_x == 0 && move_y == 0
		{
			sprite_index = spr_pc_idle;
			image_index = 0 //reset frame
		}
		
		if move_x == 0 && move_y == 0 && _attack_input == true && cooldown == 0
		{
			sprite_index = spr_pc_attack;
			image_index = 0; //reset frame
			attack = true;
			global.stun = true;
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
			cooldown = 5;
			global.stun = false;
		}
		
		if move_x != 0
		{
			sprite_index = spr_pc_run; //swap to run animation when moving
			image_index = 0; //reset frame count
		}
	
		if move_y != 0
		{
			sprite_index = spr_pc_run; 
			image_index = 0; //reset frame count
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
		
		if move_x != 0
		{
			sprite_index = spr_pc_run; //swap to run animation when moving
			image_index = 0; //reset frame count
		}
	
		if move_y != 0
		{
			sprite_index = spr_pc_run; 
			image_index = 0; //reset frame count
		}
		break;
	#endregion
	#region death
	case spr_pc_death:
		image_speed = 1;
		if image_index == 18
		{
			room_goto(rm_over);
		}
		
		break;
	#endregion
	default:
		image_speed = 1;
		break;
}
