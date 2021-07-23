var bar_scale = 4;
var bar_pos_x = 10;
var bar_pos_y = 10;

var health_perceng = .75;
var armor_perceng = .35;
var health_width = sprite_get_width(spr_gui_bar_color) * bar_scale * health_perceng;
var armor_width = sprite_get_width(spr_gui_bar_color) * bar_scale * armor_perceng;
var bar_height = sprite_get_height(spr_gui_bar_color) * bar_scale + bar_scale;

var miniGunScale = 3;
var gunInfo_x = display_get_gui_width() - 10;
var gunInfo_y = 10;
draw_sprite_ext(spr_dukeStuff_gui, 0, gunInfo_x, gunInfo_y, miniGunScale,miniGunScale, 0, -1, 1);
draw_set_halign(fa_right);
draw_text(gunInfo_x, gunInfo_y + sprite_get_height(spr_dukeStuff_gui) * miniGunScale, "10 / 36");
draw_set_halign(fa_left)

draw_sprite_stretched(spr_gui_bar_color, 1, bar_pos_x + 1, bar_pos_y + 1, health_width, bar_height);
draw_sprite_stretched(spr_gui_bar_color, 0, bar_pos_x + 1, bar_pos_y + bar_height + 1, armor_width, bar_height);
draw_sprite_ext(spr_gui_bar,0, bar_pos_x,bar_pos_y, bar_scale,bar_scale,0,c_white,1);

var debug_pos = display_get_gui_height() - 70;

draw_text(10,debug_pos,CAMERA.Position);
draw_text(10,debug_pos + 20,CAMERA.Rotation);
draw_text(10,debug_pos + 40,"FPS: "+string(FPS) + "( "+string(FPS_real)+" )");

draw_sprite(spr_crosshair, 0, display_get_gui_width() / 2, display_get_gui_height()/2);
var gunScale = 4;
draw_sprite_ext(spr_dukeStuff, gunIndex, display_get_gui_width() + GunGuiOffset.x, display_get_gui_height() + GunGuiOffset.y,gunScale,gunScale,0,c_white, 1);
