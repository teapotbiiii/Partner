draw_self();

if show_text == true
{
	draw_text(x + 100, y - 200, "Hold E to activate");
}

if jammer_switch == true
{
	draw_text(x - 50, y - 250, "ACTIVATED");
	show_text = false;
}

if jammer_timer > 0 && show_progress == true && jammer_switch == false
{
	draw_rectangle(x + 140, y - 141, x + 290, y - 154, true)
	draw_rectangle(x + 140, y - 140, lerp(x + 140, x + 440, progress * 0.1), y - 155, false)
}