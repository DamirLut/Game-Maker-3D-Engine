if z > 0{
	x += Velocity.x;
	y += Velocity.y;
	z += Velocity.z;

	Velocity.x /= 1.01;
	Velocity.y /= 1.01;
	Velocity.z /= 1.01;

	Velocity.z -= .25;

	mesh.Position.x = x;
	mesh.Position.y = y;
	mesh.Position.z = z;
}
mesh.Rotation.z = point_direction(x,y,obj_main.x,obj_main.y) + 90;


if z <= 0{
	instance_destroy();
}
