shader_type spatial;

// Snippet start here
uniform float max_height = 4;
uniform float base_y = 0;
uniform float crumple_tween : hint_range(0, 1) = 1;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}


void vertex() {
	float rand = random(vec2(VERTEX.x, VERTEX.z));
	vec3 new_position = vec3(VERTEX.x, rand * max_height + base_y, VERTEX.z);
	VERTEX = VERTEX * (1.0f - crumple_tween ) + new_position * crumple_tween;
	COLOR = vec4(NORMAL.xyz, 1.0);
}

// Snippet end here
