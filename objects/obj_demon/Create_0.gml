event_inherited();

mesh.Texture = sprite_get_texture(spr_enemy_demon, 0);

Speed = .1;

Width = sprite_get_width(spr_enemy)/1.5;
Height = sprite_get_height(spr_enemy)/2;
mesh.Position.z = 0;
z = 0;

mass = 3;

var s = 1/sprite_get_width(spr_enemy);

mesh.Vertex.build_begin();
mesh.Vertex.vertex_quad(
	new Vector3(-Width/2,0,Height),
	new Vector3(Width/2,0, Height),
	new Vector3(Width/2, 0, 0),
	new Vector3(-Width/2,0,0),
	[new Vector2(), new Vector2(1,s * 67)],
	new Vector3(1,0,0)
);
mesh.Vertex.build_end();