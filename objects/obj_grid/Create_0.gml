var _columns = 15; //set this to how many columns of corn
var _rows = 15; // set this to how many rows of corn
var _width = 256; //set this to your sprite width
var _height = 256; //set this to your sprite height
var _offset = 600; //set this to how far from (0,0) you want your grid to start

for(i = 0; i < _columns; i++)
{
    for(ii = 0; ii < _rows; ii++)
	{
        grid_x = _width * i;
        grid_y = _height * ii;
        instance_create_depth(grid_x + _offset,grid_y + _offset,0,obj_corn);
    }
}