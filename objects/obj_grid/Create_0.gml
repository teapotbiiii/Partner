var _columns = 20; //set this to how many columns of corn
var _rows = 20; // set this to how many rows of corn
var _width = 197; //set this to your sprite width
var _height = 197; //set this to your sprite height
var _offset = 600; //set this to how far from (0,0) you want your grid to start

for(ii = 0; ii < _columns; ii++)
{
    for(i = 0; i < _rows; i++)
	{
        grid_x = i * _width;
        grid_y = ii * _height;
        instance_create_depth(grid_x + _offset, grid_y + _offset, 0, obj_corn);
    }
}