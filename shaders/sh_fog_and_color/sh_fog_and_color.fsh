//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_worldPosition;

uniform float fogStart;
uniform float fogEnd;
uniform vec4 fogColor;
uniform vec4 color;
uniform float fogEnable;

void main()
{
	vec4 baseColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	if (baseColor.a > 0.0){
		vec3 fogOrigin = vec3(0.0,0.0,0.0);
		float dist = length(v_worldPosition - fogOrigin);
	
		float fraction = clamp((dist - fogStart) / (fogEnd - fogStart), 0.0, 1.0);
	    gl_FragColor = color * texture2D( gm_BaseTexture, v_vTexcoord );
		if (fogEnable == 1.0){
			gl_FragColor = mix(gl_FragColor, fogColor, fraction);
		}
	}
}
