mesh = new Mesh();
z = 5;

mesh.Texture = sprite_get_texture(spr_ammo_box,0);
mesh.Position.x = x;
mesh.Position.y = y;

Width = sprite_get_width(spr_ammo_box) / 16 * 6;
Height = sprite_get_width(spr_ammo_box) / 16 * 3;
Depth = Height;

var s = 16/sprite_get_width(spr_ammo_box);

mesh.Vertex.build_begin();
/// RIGHT
mesh.Vertex.vertex_quad(
	new Vector3( Width/2,	Depth/2,		Height),
	new Vector3( Width/2,	- Depth/2,		Height),
	new Vector3( Width/2,	- Depth/2,		0),
	new Vector3( Width/2,	Depth/2,	0),
	[new Vector2(s * 2,s * 2), new Vector2(s * 3,s * 3)],new Vector3(1,0,0)
);
/// LEFT
mesh.Vertex.vertex_quad(
	new Vector3(- Width/2,	- Depth/2,Height),
	new Vector3(- Width/2,	Depth/2,	Height),
	new Vector3(- Width/2,	Depth/2,	0),
	new Vector3(- Width/2,	- Depth/2,		0),
	[new Vector2(s * 2,s * 2), new Vector2(s * 3,s * 3)],new Vector3(-1,0,0)
)
/// FRONT
mesh.Vertex.vertex_quad(
	new Vector3(- Width/2,	Depth/2,		 Height),
	new Vector3( Width/2,	Depth/2,		 Height),
	new Vector3( Width/2,	Depth/2,		0),
	new Vector3(- Width/2,	Depth/2,		0),
	[new Vector2(0,0), new Vector2(s * 2,s)],new Vector3(0,1,0)
)
/// BACK
mesh.Vertex.vertex_quad(
	new Vector3( Width/2,	- Depth/2,			Height),
	new Vector3(- Width/2,	- Depth/2,			Height),
	new Vector3(- Width/2,	- Depth/2,			0),
	new Vector3( Width/2,	- Depth/2,			0),
	[new Vector2(0,s), new Vector2(s * 2,s * 2)],new Vector3(0,-1,0)
)
///TOP
mesh.Vertex.vertex_quad(
	new Vector3(- Width/2,	- Depth/2,	Height),
	new Vector3( Width/2,	- Depth/2,	Height),
	new Vector3( Width/2,	Depth/2,		Height),
	new Vector3(- Width/2,	Depth/2,		Height),
	[new Vector2(s * 2,0), new Vector2(s * 3,s * 2)],new Vector3(0,0,1)
)

mesh.Vertex.build_end();
MainScene.add(mesh);