if (keyboard_check(ord("D")) && !keyboard_check(ord("A")))
{
	_cam_facing = 1
}

else if (keyboard_check(ord("A")) && !keyboard_check(ord("D")))
{
	_cam_facing = -1
}

if (keyboard_check(ord("W")) && !keyboard_check(ord("S")))
{
	_cam_facing = 1
}

else if (keyboard_check(ord("S")) && !keyboard_check(ord("W")))
{
	_cam_facing = -1
}


if (instance_exists(target))
{
	x_to = target.x + _cam_facing * x_offset;
	y_to = target.y + y_offset;
}

x += (x_to - x) / cam_trackspeed;
y += (y_to - y) / cam_trackspeed;

x = clamp(x, view_w_half, room_width - view_w_half);
y = clamp(y, view_h_half, room_height - view_h_half);

camera_set_view_pos(cam, x - view_w_half, y - view_h_half);