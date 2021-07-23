if HP < 0{
	obj_main.alarm[2] = 1;
}

event_inherited();

var dir = point_direction(x,y, obj_main.x, obj_main.y);
var angle = point_direction(0, z, 0, obj_main.z + obj_main.CameraHeight / 2);

Velocity.x += lengthdir_x(Speed, dir);
Velocity.y += lengthdir_y(Speed, dir);
Velocity.z += lengthdir_y(Speed, angle);

//mesh.Texture = sprite_get_texture(spr_enemy_demon, current_time / room_speed);

mesh.Position.x = x;
mesh.Position.y = y;
mesh.Position.z = z;

mesh.Rotation.z = point_direction(x,y,obj_main.x,obj_main.y) + 90;