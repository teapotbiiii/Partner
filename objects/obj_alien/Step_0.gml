depth = -y;

if point_distance(x,y,obj_player.x,obj_player.y)>1500
{
    speed = 0;
    if !place_meeting(x + zoom_x, y, obj_collision) && !place_meeting(x, y + zoom_y, obj_collision)
	{
        x += zoom_x;
        y += zoom_y;
    }
    else if place_meeting(x + zoom_x, y, obj_collision) || place_meeting(x, y + zoom_y, obj_collision)
	{
        zoom_x = random_range(-5,5);
        zoom_y = random_range(-5,5);
    }
}

if point_distance(x,y,obj_player.x,obj_player.y)<=1500
{
	move_towards_point(obj_player.x,obj_player.y,12);
} 

if place_meeting(x, y, obj_alien) && place_meeting(x,y,obj_player)
{
	attack = true;
	sprite_index = spr_al_attack;
}

//face x direction
//Animation Controller
image_speed = 1;
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