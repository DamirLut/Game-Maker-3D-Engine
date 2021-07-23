event_inherited();
var dir = point_direction(x,y, obj_main.x, obj_main.y);

Velocity.x += lengthdir_x(Speed, dir);
Velocity.y += lengthdir_y(Speed, dir);

mesh.Texture = sprite_get_texture(spr_enemy, current_time / room_speed);

mesh.Position.x = x;
mesh.Position.y = y;
mesh.Position.z = z;

mesh.Rotation.z = point_direction(x,y,obj_main.x,obj_main.y) + 90;