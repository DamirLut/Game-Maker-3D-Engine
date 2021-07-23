if LockMouse{
    CAMERA.Rotation.x -= (display_mouse_get_x() -display_get_width()/2)/10; 
    CAMERA.Rotation.y += (display_mouse_get_y() -display_get_height()/2)/15;
    CAMERA.Rotation.y = clamp(CAMERA.Rotation.y, -89, 89);
    display_mouse_set(display_get_width()/2,display_get_height()/2);
}

if keyboard_check_released(vk_f1){
    LockMouse = !LockMouse;
	window_set_cursor(LockMouse ? cr_none : cr_default);
}
if keyboard_check_released(vk_f2){
    global.LightEnable = !global.LightEnable;
}

var forward = keyboard_check(ord("W")) - keyboard_check(ord("S"));
var side = keyboard_check(ord("A")) - keyboard_check(ord("D"));

if keyboard_check_pressed(vk_space){
	Velocity.z += 5;
}

var spd = 3.25;

Velocity.x = lengthdir_x(spd * forward, CAMERA.Rotation.x) + lengthdir_x(spd * side, CAMERA.Rotation.x + 90);
Velocity.y = lengthdir_y(spd * forward, CAMERA.Rotation.x) + lengthdir_y(spd * side, CAMERA.Rotation.x + 90);

Velocity.x /= Friction;
Velocity.y /= Friction;
Velocity.z /= Friction;
Velocity.z -= Gravity;

var upX = side != 0 ? dcos(CAMERA.Rotation.x + 90 * side) * .1 : 0;
var upY = side != 0 ? -dsin(CAMERA.Rotation.x + 90 * side) * .1: 0;

var ggx = 0;
var ggy = 0;
if side != 0 || forward != 0{
	ggx = cos(x / 30) * 15;
	ggy = -sin(y / 30) * 15;
}
GunGuiOffset.x = lerp(GunGuiOffset.x, ggx, .15);
GunGuiOffset.y = lerp(GunGuiOffset.y, ggy, .15);

CAMERA.Up.x = lerp(CAMERA.Up.x, upX, .15);
CAMERA.Up.y = lerp(CAMERA.Up.y, upY, .15);

CollisionRender(Velocity);

CAMERA.Position.z = z + CameraHeight;
CAMERA.Position.x = x
CAMERA.Position.y = y;

if mouse_check_button(mb_left) && canShoot{
	canShoot = false;
	Shooting = true;
	gunIndex = 0;
	var start = new Vector3();
	start.set(CAMERA.Position);
	start.z += CameraHeight/2;
	var dir = CAMERA.Rotation.x;
	var angle = CAMERA.Rotation.y;
	for(var i = 1; i < 512; i+=2){
		start.x += dcos(dir) * i * dcos(angle)	//lengthdir_x(i, dir);
		start.y -= dsin(dir) * i * dcos(angle)	//lengthdir_y(i, dir);
		start.z -= dsin(angle) * i				//lengthdir_y(i, angle);
		if position_meeting_3d(start.x, start.y,start.z, obj_collision, 2) || start.z <= 0{
			var object = position_meeting_3d(start.x, start.y,start.z, obj_collision, 2);
			var parent = object ? object_get_parent(object.object_index) : noone ;
			if object show_debug_message("Collide with: "+object_get_name(object.object_index));
			repeat(irandom_range(5,10)){
				with instance_create_depth(start.x + random_range(-2,2), start.y + random_range(-2,2), 0, obj_particle){
					z = start.z + random_range(-2,2);
					if z <= 2  z = 2;
					Velocity = new Vector3(random_range(-3,3), random_range(-3,3), random_range(1, 5));
					image_blend = object ? (parent == obj_entity ? c_red : c_white) : c_white;
				}
				if object && variable_struct_exists(object,"Velocity"){
					with(object){
						var strength = (1 - ( object.z - start.z ) / object.Height)/object.mass;
						//Velocity.x += lengthdir_x(strength, dir);
						//Velocity.y += lengthdir_y(strength, dir);
						//Velocity.z += lengthdir_y(strength, angle);
						Velocity.x += dcos(dir) * strength * dcos(angle)	//lengthdir_x(i, dir);
						Velocity.y -= dsin(dir) * strength * dcos(angle)	//lengthdir_y(i, dir);
						Velocity.z -= dsin(angle) * strength				//lengthdir_y(i, angle);
					}
				}
				if object && parent == obj_entity{
					object.HP -= 10;
				}
			}
			break;
		}
	}
	alarm[0] = ShootReload;
}
if Shooting{
	gunIndex += (sprite_get_number(spr_dukeStuff) * 2) / room_speed
	if gunIndex > sprite_get_number(spr_dukeStuff){
		Shooting = false;
		gunIndex = 0;
	}
}