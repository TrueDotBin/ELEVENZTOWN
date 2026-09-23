shader_type canvas_item;

uniform float progress: hint_range(0.0, 1.0) = 0.0;
uniform bool reverse = false;
uniform vec2 tiles = vec2(72.625, 40.5);

void fragment() {
	vec2 tilePos = UV * tiles;
	vec2 frac = fract(tilePos);
	vec2 direction = abs(frac - 0.5);
	
	if (!reverse) {
		if (direction.x + direction.y > progress) {
			discard;
		}
	}
	else {
		if (direction.x + direction.y < progress) {
			discard;
		}
	}
}