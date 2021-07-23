CollisionRender(Velocity);

Velocity.x /= Friction;
Velocity.y /= Friction;
Velocity.z /= Friction;
Velocity.z -= Gravity;

if HP <= 0{
	instance_destroy();
	MainScene.remove(mesh);
}