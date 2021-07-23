FPS_all += fps_real;
FPS_Count ++;
 FPS_real = round(fps_real);
if (FPS_Count >= fps){
	FPS = round(FPS_all / FPS_Count);
    FPS_Count = 0;
    FPS_all = 0;
}

gpu_set_cullmode(cull_noculling);