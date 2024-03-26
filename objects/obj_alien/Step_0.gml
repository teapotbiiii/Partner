if point_distance(x,y,obj_player.x,obj_player.y)>1500
{
    speed = 0;
    if !place_meeting(x+zoom_x,y,obj_collision) && !place_meeting(x,y+zoom_y,obj_collision)
	{
        x += zoom_x;
        y += zoom_y;
    }
    else if place_meeting(x+zoom_x,y,obj_collision) || place_meeting(x,y+zoom_y,obj_collision)
	{
        zoom_x = random_range(-5,5);
        zoom_y = random_range(-5,5);
    }
}

if point_distance(x,y,obj_player.x,obj_player.y)<=1500
{
        move_towards_point(obj_player.x,obj_player.y,12);
} 
