 ///Player movement
//Get movement input
var _x_input = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _y_input = keyboard_check(ord("S")) - keyboard_check(ord("W"));
var _attack_input = keyboard_check_pressed(ord("F"));

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
	image_xscale = sign(move_x); //make the sprite face the x movement direction
}

/*
switch (sprite_index) //handles cases for switching between animations
{
	#region idle
	case spr_pc_idle: //what happens when playing the idle animation
		image_speed = 1;
		if move_x != 0 && grounded
		{
			sprite_index = spr_pc_run; //swap to run animation when moving and on ground
			image_index = 0; //reset frame count
		}
	
		if move_y < 0
		{
			sprite_index = spr_pc_jump; //swap to jump if moving up
			image_index = 0; //reset frame count
		}
	
		if move_y > 0
		{
			sprite_index = spr_pc_fall; //swap to fall if moving down
			image_index = 0; //reset frame count
		}
		break;
	#endregion
	#region run
	case spr_pc_run: //what happens when playing the run animation
		image_speed = 1;
		if move_x == 0 && grounded
		{
			sprite_index = spr_pc_brake; //swap to brake animation when no x movement and on ground
			image_index = 0; //reset frame count
		}
	
		if move_y < 0
		{
			sprite_index = spr_pc_jump; //swap to jump if moving up
			image_index = 0; //reset frame count
		}
		
		if move_y > 0
		{
			sprite_index = spr_pc_fall; //swap to fall if moving down
			image_index = 0; //reset frame count
		}
		break;
	#endregion
	#region brake	
	case spr_pc_brake: //what happens when the brake animation is playing
		image_speed = 1;
		if move_x != 0 & grounded 
		{
			sprite_index = spr_pc_run; //swap to run animation if moving and on ground
			image_index = 0; //reset frame count
		}
		
		if image_index == 2 //SET TO LAST FRAME OF BRAKE ANIMATION
		{
			sprite_index = spr_pc_idle; //swap to idle if animation finishes
			image_index = 0; //reset frame count
		}
		
		if move_y < 0
		{
			sprite_index = spr_pc_jump; //swap to jump if moving up
			image_index = 0; //reset frame count
		}
		
		if move_y > 0
		{
			sprite_index = spr_pc_fall; //swap to fall if moving down
			image_index = 0; //reset frame count
		}
		break;
	#endregion
	#region jump	
	case spr_pc_jump: //what happens when the jump animation is playing
		image_speed = 1;
		if image_index == 3 //SET TO LAST FRAME OF JUMP ANIMATION
		{
			image_speed = 0; //stop animation if on last frame
		}
		
		if move_y > 0
		{
			sprite_index = spr_pc_fall; //swap to fall animation if moving down
			image_index = 0; //reset frame count
		}
		break;
	#endregion
	#region fall
	case spr_pc_fall: //what happens when the fall animation is playing
		image_speed = 1;
		if image_index = 4 //SET TO LAST FRAME OF FALL ANIMATION
		{
			image_speed = 0; //stop aniamtion if on last frame
		}
		
		if grounded && move_x = 0
		{
			sprite_index = spr_pc_land; //swap to land animation if on ground and not moving
			image_index = 0; //reset frame count
		}
		if grounded && move_x != 0
		{
			sprite_index = spr_pc_run; //swap to run animation if on ground and moving
			image_index = 0; //reset frame count
		}
		break;
	#endregion
	#region land	
	case spr_pc_land: //what happens when the land animation is playing
		image_speed = 1;
		if image_index == 2 //SET TO LAST FRAME OF LAND ANIMATION
		{
			sprite_index = spr_pc_idle; //swap to idle animation if on last frame
			image_index = 0; //reset frame count
		}
		
		if move_x != 0
		{
			sprite_index = spr_pc_run; //swap to run animation if moving
			image_index = 0; //reset frame count
		}
		break;
	#endregion
	default:
		image_speed = 1;
		break;	
}