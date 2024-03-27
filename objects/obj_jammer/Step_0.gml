if point_distance(x,y,obj_player.x,obj_player.y) <= 50
{
	draw_text(obj_player.x + 50,obj_player.y - 50, "Hold E to activate")
	
    if keyboard_check(ord("E"))
	{
        
		if jammer_switch = true
		{
			draw_text(obj_player.x + 700,obj_player.y - 500, jammer_counter + " / 5")
		}
	}
}