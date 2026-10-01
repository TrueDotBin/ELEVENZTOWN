shader_type canvas_item;

uniform float corner_radius : hint_range(0.0, 0.5) = 0.1;

void fragment() {
    vec2 uv = UV;
    float r = corner_radius;

    vec2 pos = abs(uv - 0.5) * 2.0;
    vec2 corner = vec2(1.0 - r);
    
    if (pos.x > corner.x && pos.y > corner.y) {
        float d = distance(pos, corner);
        if (d > r) {
            COLOR.a = 0.0;
        }
    }
    
    COLOR *= texture(TEXTURE, UV);
}