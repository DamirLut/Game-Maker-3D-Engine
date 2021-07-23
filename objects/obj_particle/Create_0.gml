mesh = new Mesh();

z = 16;

mesh.Texture = sprite_get_texture(s_particle, 0);
mesh.Position.x = x;
mesh.Position.y = y;
mesh.Position.z = z;
var w = sprite_get_width(s_particle);
var h = sprite_get_height(s_particle);

mesh.Vertex.build_begin();
mesh.Vertex.vertex_quad(
	new Vector3(-w/2,0,h/2),
	new Vector3(w/2,0, h/2),
	new Vector3(w/2, 0, -h/2),
	new Vector3(-w/2,0,-h/2),
	[new Vector2(), new Vector2(1,1)],
	new Vector3(1,0,0)
);
mesh.Vertex.build_end();

Velocity = new Vector3();