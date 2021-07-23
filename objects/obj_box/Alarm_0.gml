//Level.Visible = Visible;
//Level.Texture = sprite_get_texture(sprite_index, image_index);
Width = image_xscale * sprite_get_width(sprite_index) ;
Depth = image_yscale * sprite_get_height(sprite_index);
//Level.Position.x = x;
//Level.Position.y = y;
//Level.Position.z = z;

var texture = function(type){
	var xs = ceil(image_xscale)
	var ys = ceil(image_yscale)
	switch (type){
		case 1:{
			if image_xscale >= image_yscale{
				return [new Vector3(), new Vector3(1, 1)];
			}
			return [new Vector3(), new Vector3(ys, xs)];
			break;
		}
		case 2:{
			if image_xscale >= image_yscale{
				return [new Vector3(), new Vector3(xs, ys)];
			}
			return [new Vector3(), new Vector3(1 + xs / ys,xs)];
			break;
		}
		case 3:{
			return [new Vector3(), new Vector3(xs, ys)];
			break;
		}
	}	
}

texture = method(self, texture);
/// RIGHT
Level.Vertex.vertex_quad(
	new Vector3(x + Width,	y +Depth,		z +Height),
	new Vector3(x + Width,	y,					z +Height),
	new Vector3(x + Width,	y,					z),
	new Vector3(x + Width,	y +Depth,		z),
	texture(1),new Vector3(1,0,0)
);
/// LEFT
Level.Vertex.vertex_quad(
	new Vector3(x,	y,										z + Height),
	new Vector3(x,	y + Depth,						z + Height),
	new Vector3(x,	y + Depth,						z),
	new Vector3(x,	y,										z),
	texture(1),new Vector3(-1,0,0)
)
/// FRONT
Level.Vertex.vertex_quad(
	new Vector3(x,					y +Depth,		z + Height),
	new Vector3(x + Width,	y +Depth,		z + Height),
	new Vector3(x + Width,	y +Depth,		z),
	new Vector3(x,					y +Depth,		z),
	texture(2),new Vector3(0,1,0)
)
/// BACK
Level.Vertex.vertex_quad(
	new Vector3(x + Width,	y,						z + Height),
	new Vector3(x,					y,						z + Height),
	new Vector3(x,					y,						z),
	new Vector3(x + Width,	y,						z),
	texture(2),new Vector3(0,-1,0)
)
///TOP
Level.Vertex.vertex_quad(
	new Vector3(x,					y,						 z + Height),
	new Vector3(x + Width,	y,						 z + Height),
	new Vector3(x + Width,	y + Depth,		 z + Height),
	new Vector3(x,					y + Depth,		 z + Height),
	texture(3),new Vector3(0,0,1)
)
///Bottom
Level.Vertex.vertex_quad(
	new Vector3(x + Width,	y,						z),
	new Vector3(x,					y,						z),
	new Vector3(x,					y + Depth,		z),
	new Vector3(x + Width,	y + Depth,		z),
	texture(3),new Vector3(0,0,-1)
);