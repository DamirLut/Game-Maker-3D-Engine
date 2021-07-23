InitEngine();
#macro CAMERA obj_main.__camera__
#macro MainScene obj_main.__MainScene__

CAMERA = new Camera();
CAMERA.Position.z = 10;
CAMERA.Position.x = x;
CAMERA.Position.y = y;

Velocity = new Vector3();


global.LightEnable = false;

#macro Level obj_main.__level__

MainScene = new Scene();

Level = new Mesh();
Level.Texture = sprite_get_texture(spr_prototype, 0);
Level.TextureRepeat = true;
Level.Vertex.build_begin();
MainScene.add(Level);
alarm[1] = 2;

z = 50;
CameraHeight = 32;
Height = 16;

LockMouse = false;

FPS_all = 0;
FPS_Count  = 0;
FPS_real = 0;

fogEnd = 4096;
fogStart = 4000;

MainScene.Light.FogEnd = fogEnd;
MainScene.Light.FogStart = fogStart;
CAMERA.zFar = fogEnd;
CAMERA.Update();

fogColor = make_color_rgb(90, 90, 90);
layer_background_blend(layer_background_get_id(layer_get_id("Background")), fogColor);
MainScene.Light.FogColor = fogColor;

Shooting = false;
gunIndex = 0;
canShoot = true;
ShootReload = 45
GunGuiOffset = new Vector2();