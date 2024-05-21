shader_type spatial;

render_mode unshaded,fog_disabled;

uniform vec3 color_top: source_color;
uniform vec3 color_bottom: source_color;
uniform float y_multiplier;
uniform float opacity = 0.5;

varying float y;

void vertex() {
	y = VERTEX.y;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = mix(color_bottom,color_top, clamp(y * y_multiplier,0.0,1.0));
	ALPHA = smoothstep(0.02,0.06,mod( clamp(abs((y+0.1))*y_multiplier,0.0,1.0) - TIME * 0.03,0.25));
	ALPHA = mix(ALPHA,1.0, clamp(y *y_multiplier,0.0,1.0)+0.1);
	ALPHA *= opacity;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
