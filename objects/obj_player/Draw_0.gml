draw_self();

if global.health == 2
{
	draw_sprite(spr_ouchie, 0, obj_player.x, obj_player.y);
}

if global.health == 1
{
	draw_sprite(spr_ouch, 0, obj_player.x, obj_player.y);
}















