var columns = 10; //set this to how many columns of corn
var rows = 10; // set this to how many rows of corn
var width = 64; //set this to your sprite width
var height = 64; //set this to your sprite height
var offset = 100; //set this to how far from (0,0) you want your grid to start

for(i = 0; i < columns; i++)
{
    for(ii = 0; ii < rows; ii++)
	{
        grid_x = width * i;
        grid_y = height * ii;
        instance_create_depth(grid_x + offset,grid_y + offset,0,obj_corn);
    }
}