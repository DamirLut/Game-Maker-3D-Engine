Height = 16;
for(var i =1; i < 5; i++){
	with(instance_create_depth(x, y + 64 *i, 0, obj_box)){
		Height = 16 + 16 * i;
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
	}
}