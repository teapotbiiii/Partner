view_x = camera_get_view_x(view_camera[0]);
view_y = camera_get_view_y(view_camera[0]);

if global.jammer_counter == 5
{
	room_goto(rm_win);
}