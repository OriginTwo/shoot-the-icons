shader_type canvas_item;

uniform sampler2D noise_texture : source_color, repeat_enable;
uniform vec3 color : source_color;
uniform float alpha : hint_range(0.0, 1.0) = 1.0;
uniform float vignette_lower_edge : hint_range(0.0, 1.0) = 0.4;
uniform float vignette_upper_edge : hint_range(0.0, 1.0) = 0.8;
uniform float time_scale : hint_range(0.0, 2.0) = 0.2;

const mat4 BAYER_MATRIX = mat4(
	vec4( 0.0 / 16.0,  8.0 / 16.0,  2.0 / 16.0, 10.0 / 16.0),
	vec4(12.0 / 16.0,  4.0 / 16.0, 14.0 / 16.0,  6.0 / 16.0),
	vec4( 3.0 / 16.0, 11.0 / 16.0,  1.0 / 16.0,  9.0 / 16.0),
	vec4(15.0 / 16.0,  7.0 / 16.0, 13.0 / 16.0,  5.0 / 16.0));

float get_dither_value(vec2 pixel) {
	int x = int(pixel.x - 4.0 * floor(pixel.x / 4.0));
	int y = int(pixel.y - 4.0 * floor(pixel.y / 4.0));
	return BAYER_MATRIX[x][y];
}

void fragment() {
	float time = TIME * time_scale;
	
	vec2 shifted_uv = vec2(UV.x + sin(time*0.2), UV.y + sin(time*0.2));
	float n1 = texture(noise_texture, shifted_uv).r;
	shifted_uv = vec2(UV.x*1.2 - sin(time*0.5), UV.y*1.2 - sin(time*0.5));
	float n2 = texture(noise_texture, shifted_uv).r;
	shifted_uv = vec2(UV.x*0.7 - sin(time*0.4), UV.y*0.7 + sin(time*0.4));
	float n3 = texture(noise_texture, shifted_uv).r;
	float n = (n1 + n2*0.5 + n3*0.5)*0.5;
	
	// vignette
	float dist = distance(UV, vec2(0.5));
	n *= smoothstep(vignette_lower_edge, vignette_upper_edge, dist)*2.0*0.9;
	
	n *= alpha;
	
	float threshold = get_dither_value(UV * vec2(textureSize(noise_texture, 0)));
	if (n <= threshold*0.9 + 0.1) {
		discard;
	}
	
	COLOR = vec4(color, 1.0);
}
