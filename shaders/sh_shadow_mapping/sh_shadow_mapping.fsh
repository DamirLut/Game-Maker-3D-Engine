varying float v_vLightDepth;
varying vec2  v_vTexcoord;
varying vec4  v_vColour;

const float SCALE_FACTOR = 256.0 * 256.0 * 256.0 - 1.0;
vec3 packFloatInto8BitVec3(float val01)
{
	float zeroTo24Bit = val01 * SCALE_FACTOR;
	return floor(
		vec3(
			mod(zeroTo24Bit, 256.0),
			mod(zeroTo24Bit / 256.0, 256.0),
			zeroTo24Bit / 256.0 / 256.0
			)
		) / 255.0;
}

void main()
{
	vec4 baseColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	if (baseColor.a > 0.0){
		vec3 packed_depth = packFloatInto8BitVec3(v_vLightDepth);
		gl_FragColor = vec4(packed_depth, 1.0);
	}
}