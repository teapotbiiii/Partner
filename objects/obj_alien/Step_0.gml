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
		}
		break;
	#endregion
	#region attack
	case spr_al_attack:
		image_speed = 1;
		if image_index == 2
		{
			sprite_index = spr_al_run; //swap to idle if animation finishes
			image_index = 0; //reset frame
			attack = false;
			global.attack = false;
			cooldown = 8;
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