MainScene.draw(global.LightEnable);

shader_set(sh_fog_and_color);
shader_set_uniform_f(shader_get_uniform(sh_fog_and_color,"fogStart"), MainScene.Light.FogStart);
shader_set_uniform_f(shader_get_uniform(sh_fog_and_color,"fogEnd"), MainScene.Light.FogEnd);
shader_set_uniform_f(shader_get_uniform(sh_fog_and_color,"fogEnable"), global.LightEnable);
var col = [color_get_red(MainScene.Light.FogColor) / 255, color_get_green(MainScene.Light.FogColor) / 255, color_get_blue(MainScene.Light.FogColor) / 255, 1];
shader_set_uniform_f_array(shader_get_uniform(sh_fog_and_color,"fogColor"), col);
with(obj_particle){
	var col = [color_get_red(image_blend) / 255, color_get_green(image_blend) / 255, color_get_blue(image_blend) / 255, 1];
	shader_set_uniform_f_array(shader_get_uniform(sh_fog_and_color,"color"), col);
	mesh.draw();
}
shader_reset();