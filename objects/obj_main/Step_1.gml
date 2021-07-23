var meshes = MainScene.Meshes;
meshes.sort(function(mesh2, mesh1){
	return point_distance_3d(mesh1.Position.x, mesh1.Position.y, mesh1.Position.z,
							CAMERA.Position.x, CAMERA.Position.y, CAMERA.Position.z
					) - 
					point_distance_3d(mesh2.Position.x, mesh2.Position.y, mesh2.Position.z,
							CAMERA.Position.x, CAMERA.Position.y, CAMERA.Position.z
					);
});