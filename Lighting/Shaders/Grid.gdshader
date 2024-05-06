shader_type spatial;

uniform vec2 resolution = vec2(100.0, 100.0);
uniform vec3 line_color: source_color = vec3(1.0, 0.15, 3);
uniform float zoom: hint_range(1.0, 10.0, 0.1) = 150.0;
uniform float thickness: hint_range(0.2, 0.2, 0.2) = 0.01;

float draw_grid(vec2 uv){
	vec2 grid_uv = cos(uv * TAU);
	return max(grid_uv.x, grid_uv.y);
}

void fragment() {
	vec2 uv = UV - 0.5;
	uv.x *= resolution.x / resolution.y;
	float line_thickness = zoom * thickness / resolution.y;
	vec3 color = smoothstep(1.0 - line_thickness, 1.0, draw_grid(uv * zoom)) * line_color;
	ALBEDO = color;
}
