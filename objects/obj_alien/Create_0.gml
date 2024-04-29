//how often alien changes direction
alarm[0] = random_range(2,7) * room_speed;

//alien speed
move_x = random_range(-5,5);
move_y = random_range(-5,5);

attack = false;
global.attack = false;
cooldown = 0;
cooldown_speed = 1/room_speed;

stun_timer = 0;