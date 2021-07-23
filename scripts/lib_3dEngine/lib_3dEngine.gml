function InitEngine(){
	gpu_set_ztestenable(true);
	gpu_set_zwriteenable(true);
	gpu_set_alphatestenable(true);
	vertex_format_begin();
		vertex_format_add_position_3d();
		vertex_format_add_normal();
		vertex_format_add_color();
		vertex_format_add_texcoord();
	global.FORMAT = vertex_format_end();
	
	#macro Friction 1.01
	#macro Gravity .25
	
	#macro LIGHT_SIZE 720
	#macro LIGHT_LENGHT 128
}
function Camera() constructor{
	Position = new Vector3() ///@is {Vector3}
	Rotation = new Vector2(); ///@is {Vector2}
	Up = new Vector3(0,0,1); ///@is {Vector3}
	To = new Vector3(0,0,0); ///@is {Vector3}
	FOV = 60; ///@is {number}
	Aspect = window_get_width()/window_get_height();
	view = 0; ///@is {number}
	width = 1920; ///@is {number}
	height = 1080; ///@is {number}
	zFar = 320; 
	Update();
	static Update = function(){
		camera_set_view_size(view_camera[view],width,height);
		camera_set_proj_mat(view_camera[view],matrix_build_projection_perspective_fov(-FOV,-Aspect,1,zFar));
	}
	static Render = function(){
		To.x = Position.x + dcos(Rotation.x) * dcos(Rotation.y);
		To.y = Position.y - dsin(Rotation.x) * dcos(Rotation.y);
		To.z = Position.z - dsin(Rotation.y);
		var matrix = matrix_build_lookat(
				Position.x, Position.y,Position.z,
				To.x,To.y,To.z,
				Up.x,Up.y,Up.z
			);
		camera_set_view_mat(view_camera[view],matrix);
		camera_apply(view_camera[view]);
	}
}
global.BufferList = Array();
function VertexBuffer() constructor{
	global.BufferList.push(self);
	vertex = vertex_create_buffer();
	end_build = false;
	static build_begin = function(){
		end_build = false;
		vertex_begin(vertex,global.FORMAT);
		
	}
	static build_end = function(){
		vertex_end(vertex);
		end_build = true;
	}
	static build_end_fixed = function(){
		vertex_end(vertex);
		vertex_freeze(vertex);
		end_build = true;
	}
	static clear = function(){
		vertex_delete_buffer(vertex);
		vertex = vertex_create_buffer();
		end_build = false;
	}
	static vertex_add_point = function(Position/*: Vector3*/, Normal/*: Vector3*/, Texcoord/*: Vector2*/){
		vertex_position_3d(vertex,Position.x,Position.y,Position.z);
		vertex_normal(vertex,Normal.x, Normal.y,Normal.z);
		vertex_color(vertex,c_white,1);
		vertex_texcoord(vertex,Texcoord.x,Texcoord.y);
	}
	static vertex_triangle = function(p1/*: Vector3*/, p2/*: Vector3*/, p3/*: Vector3*/,Texcoord/*: Array*/, normal/*: Array*/){
		 vertex_add_point(p1, normal, Texcoord[0]);
		vertex_add_point(p2, normal, Texcoord[1]);
		vertex_add_point(p3, normal, Texcoord[2]);
	}
	static vertex_quad = function(p1/*: Vector3*/, p2/*: Vector3*/,p3/*: Vector3*/, p4/*: Vector3*/, Texcoord/*: Array*/, Normal/*: Normal*/){
		if Texcoord == undefined{
			Texcoord = [new Vector2(), new Vector2()];
		}
		vertex_triangle(p2, p3,p4, [new Vector2(Texcoord[1].x, Texcoord[0].y), new Vector2(Texcoord[1].x, Texcoord[1].y), new Vector2(Texcoord[0].x, Texcoord[1].y)],Normal);
		vertex_triangle(p2, p4,p1, [new Vector2(Texcoord[1].x, Texcoord[0].y), new Vector2(Texcoord[0].x, Texcoord[1].y), new Vector2(Texcoord[0].x, Texcoord[0].y)],Normal);
	
		
	}
	static destroy = function(){
		vertex_delete_buffer(vertex);
	}
}

function Scene() constructor{
	Light = {
		Forward: new Vector3(),
		Right: new Vector3(),
		Up: new Vector3(),
		Position: new Vector3(),
		ViewMat: matrix_build_identity(),
		ProjMat: matrix_build_identity(),
		ShadowMap: -1,
		FogStart: 140,
		FogEnd: 320,
		ForColor: c_black,
		ShadowMapShader: {
			Forward: shader_get_uniform(sh_shadow_mapping, "u_LightForward"),
			Position: shader_get_uniform(sh_shadow_mapping, "u_LightPosition"),
			Lenght: shader_get_uniform(sh_shadow_mapping, "u_LightLenght")
		},
		DirectionLightMap: {
			Forward: shader_get_uniform(sh_directional_lighting, "u_LightForward"),
			Right: shader_get_uniform(sh_directional_lighting, "u_LightRight"),
			Up: shader_get_uniform(sh_directional_lighting, "u_LightUp"),
			Position: shader_get_uniform(sh_directional_lighting, "u_LightPosition"),
			Size: shader_get_uniform(sh_directional_lighting, "u_LightSize"),
			Lenght: shader_get_uniform(sh_directional_lighting, "u_LightLenght"),
			ShadowMap: shader_get_sampler_index(sh_directional_lighting, "u_ShadowMap"),
			FogStart: shader_get_uniform(sh_directional_lighting, "fogStart"),
			FogEnd: shader_get_uniform(sh_directional_lighting,"fogEnd"),
			FogColor: shader_get_uniform(sh_directional_lighting, "fogColor")
		},
		set_light: function(from, to, up){
			self.Position.set(from);
			self.Forward.set(new Vector3(to.x - from.x, to.y - from.y, to.z - from.z));
			self.Up.set(up);
			normalize(Forward);
			cross_product(Forward, Up, Right);
			normalize(Right);
			cross_product(Right, Forward, Up);
			
			ViewMat = matrix_build_lookat(from.x,from.y,from.z, to.x,to.y,to.z, up.x,up.y,up.z);
			//ProjMat = matrix_build_projection_perspective_fov(-CAMERA.FOV,-CAMERA.Aspect,1,CAMERA.zFar);
			ProjMat = matrix_build_projection_ortho(-LIGHT_SIZE, LIGHT_SIZE, 0, LIGHT_LENGHT);
		},
		Render: function(scene){
			if !surface_exists(self.ShadowMap){
				self.ShadowMap = surface_create(LIGHT_SIZE * 2, LIGHT_SIZE * 2);
			}
			surface_set_target(self.ShadowMap);
				matrix_set(matrix_projection, self.ProjMat);
				matrix_set(matrix_view, ViewMat);
				shader_set(sh_shadow_mapping);
					shader_set_uniform_f_array(self.ShadowMapShader.Forward, self.Forward.toArray());
					shader_set_uniform_f_array(self.ShadowMapShader.Position, self.Position.toArray());
					shader_set_uniform_f(self.ShadowMapShader.Lenght, LIGHT_LENGHT);
					
					draw_clear(c_white);
					scene.draw(false);
					
				shader_reset();
			surface_reset_target();
		}
	}
	
	Meshes = Array() ///@is {array<Mesh>};
	static add = function(mesh/*: Mesh*/){
		Meshes.push(mesh);
	}
	static remove = function(mesh){
		for(var i = 0; i < Meshes.size(); i++){
			if Meshes.get(i) == mesh{
				Meshes.remove(i);
			}
		}
	}
	static draw = function(withLight){
		if withLight{
			shader_set(sh_directional_lighting);
			shader_set_uniform_f_array(Light.DirectionLightMap.Forward, Light.Forward.toArray());
			shader_set_uniform_f_array(Light.DirectionLightMap.Right, Light.Right.toArray());
			shader_set_uniform_f_array(Light.DirectionLightMap.Up, Light.Up.toArray());
			shader_set_uniform_f_array(Light.DirectionLightMap.Position, Light.Position.toArray());
			shader_set_uniform_f(Light.DirectionLightMap.Size, LIGHT_SIZE);
			shader_set_uniform_f(Light.DirectionLightMap.Lenght, LIGHT_LENGHT);
			shader_set_uniform_f(Light.DirectionLightMap.FogStart, Light.FogStart);
			shader_set_uniform_f(Light.DirectionLightMap.FogEnd, Light.FogEnd);
			var col = [color_get_red(Light.FogColor) / 255, color_get_green(Light.FogColor) / 255, color_get_blue(Light.FogColor) / 255, 1];
			shader_set_uniform_f_array(Light.DirectionLightMap.FogColor, col);
			var texShadowMap = surface_get_texture(Light.ShadowMap);
			texture_set_stage(Light.DirectionLightMap.ShadowMap, texShadowMap);
		}
		for(var i = 0; i < Meshes.size(); i++){
			if Meshes(i).Visible{
				Meshes(i).draw();
			}
		}
		if withLight{
			shader_reset();
		}
	}
}

function Mesh() constructor{
	Position = new Vector3(); ///@is {Vector3}
	Rotation = new Vector3(); ///@is {Vector3}
	Scale = new Vector3(1,1,1); ///@is {Vector3}
	Vertex = new VertexBuffer(); ///@is {VertexBuffer}
	Texture = -1; ///@is {texture}
	TextureRepeat = false;
	Visible = true;
	static toString = function(){
		return Positon.toString() + Rotation.toString() + Scale.toString();
	}
	static draw = function(){
		if Visible{
			if Vertex.end_build{
				if TextureRepeat == true{
					gpu_set_tex_repeat(true);
				}
				matrix_set(matrix_world, matrix_build(Position.x,Position.y, Position.z, Rotation.x, Rotation.y,Rotation.z, Scale.x, Scale.y,Scale.z ));
					vertex_submit(Vertex.vertex, pr_trianglelist, Texture);
				matrix_set(matrix_world,matrix_build_identity());
				gpu_set_tex_repeat(false);
			}
		}
	}
}

function position_meeting_3d(_x,_y,_z, collision){
	var Height = argument_count < 5 ? self.Height : argument[4];
	var nn, list, iter;
	iter = 0;
	list = ds_list_create();
	while iter < 1000{
		nn = instance_place(_x, _y, collision);
		if nn == noone break;
		if _z + Height > nn.z && _z < nn.z + nn.Height - 1{
			break;
		}
		nn.x += room_width;
		ds_list_add(list, nn);
		iter++;
	}
	repeat(ds_list_size(list)){
		with(list[| 0]){
			x -= room_width;
			ds_list_delete(list, 0);
		}
	}
	return nn;
}

function CollisionRender(Velocity){
	var xx = Velocity.x
	var yy =Velocity.y
	var zz =Velocity.z
	var step = 17;
	/// X
	if position_meeting_3d(x + xx, y, z, obj_box){
		var check = position_meeting_3d(x + xx, y, z, obj_box);
		if check.z + check.Height - z <= step{
			z += step;
		}else{
			while !position_meeting_3d(x + sign(xx), y, z, obj_box){
				x += sign(xx);
			}
			xx = 0
		};
	}
	if xx != 0{
		if position_meeting_3d(x + xx, y, z + Height, obj_box){
			while !position_meeting_3d(x + sign(xx), y, z + Height, obj_box){
				x += sign(xx);
			}
			xx = 0;
		}
	}
	x += xx;
	/// Y
	if position_meeting_3d(x, y + yy, z, obj_box){
		var check = position_meeting_3d(x, y + yy, z, obj_box);
		if check.z + check.Height - z <= step{
			z += step;
		}else{
			while !position_meeting_3d(x, y + sign(yy), z, obj_box){
				y += sign(yy);
			}
			yy = 0;
		}
	}
	if yy != 0{
		if position_meeting_3d(x, y + yy, z + Height, obj_box){
			while !position_meeting_3d(x, y + sign(yy), z + Height, obj_box){
				y += sign(yy);
			}
			yy = 0;
		}
	}
	y += yy;
	/// Z
	if position_meeting_3d(x, y, z + zz, obj_box){
		while !position_meeting_3d(x, y, z + sign(zz), obj_box){
			z += sign(zz);
		}
		zz = 0;
		Velocity.z = 0;
	}
	if zz != 0{
		if position_meeting_3d(x, y, z + Height + zz, obj_box){
			while !position_meeting_3d(x, y, z + Height + sign(zz), obj_box){
				z += sign(zz);
			}
			zz = 0;
			Velocity.z = 0;
		}
	}
	z += zz;
}