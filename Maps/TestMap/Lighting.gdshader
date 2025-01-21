shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform vec2 lights[1000];
uniform float lightRadiusAr[1000];
uniform vec4 lightColorAr[1000];
uniform float lightBrightnesAr[1000];

uniform vec4 lightColor : source_color = vec4(1.0, 0.8, 0.6, 1.0);

uniform int numOfLight = 1;
uniform vec4 modColor : source_color = vec4(0.0);
uniform float screenScale = 1.0;


float light_intensity(vec2 coords) {
	float intensity = 0.0;

	for (int i = 0; i < numOfLight; i++) {
		float dist = distance(coords, lights[i]);
		float falloff = smoothstep(lightRadiusAr[i] * screenScale, 0.0, dist);

		intensity += falloff * lightBrightnesAr[i];
	}

	intensity = clamp(intensity, 0.0, 1.0);
	return intensity;
}

vec4 modulate(vec4 color, float intensity) {
	vec4 modulated = mix(color * modColor, color, intensity);
	return modulated;
}

void fragment() {
	vec4 original_color = texture(screen_texture, SCREEN_UV);
	float intensity = light_intensity(FRAGCOORD.xy);
	COLOR = modulate(original_color, intensity);
}