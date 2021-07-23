varying vec2  v_vTexcoord;
varying vec4  v_vColour;
varying float v_vIllumination;
varying float v_vLightDepth;
varying vec2  v_vLightMapPosition;

varying vec3 v_worldPosition;

uniform sampler2D u_ShadowMap;
uniform float fogStart;
uniform float fogEnd;
uniform vec4 fogColor;

const float SCALE_FACTOR = 256.0 * 256.0 * 256.0 - 1.0;
const vec3 SCALE_VECTOR = vec3(1.0, 256.0, 256.0 * 256.0) / SCALE_FACTOR * 255.0;
float unpack8BitVec3IntoFloat(vec3 valRGB)
{
	return dot(valRGB, SCALE_VECTOR);
}

void main()
{
    vec3 packed_depth = texture2D(u_ShadowMap, v_vLightMapPosition).rgb;
	float depth = unpack8BitVec3IntoFloat(packed_depth);
	
	vec3 fogOrigin = vec3(0.0,0.0,0.0);
	float dist = length(v_worldPosition - fogOrigin);
	
	float fraction = clamp((dist - fogStart) / (fogEnd - fogStart), 0.0, 1.0);
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	if (v_vLightDepth > depth + 0.005)
	{
		gl_FragColor.rgb *= 0.3;
	}
	else
	{
		float smooth_illumination = smoothstep(0.1, 0.8, v_vIllumination);
		gl_FragColor.rgb *= mix(0.3, 1.0, smooth_illumination);
	}
	if (gl_FragColor.a > 0.0){
		gl_FragColor = mix(gl_FragColor, fogColor, fraction);
	}
}
