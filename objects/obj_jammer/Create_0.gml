draw_set_font(fnt_type);
draw_set_halign(bbox_left);
draw_set_valign(bbox_top);
draw_set_color(c_white);

//progress bar
progress = 0;
progress_max = 5;
progress_speed = 1/room_speed;
show_progress = false;

show_text = false;

global.jammer_counter = 0;
jammer_switch = false;
jammer_timer = 0;

//alarm[0] = 5 * room_speed;

