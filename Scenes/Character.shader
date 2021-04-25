shader_type canvas_item;
varying float VAR1;

uniform vec4 emphasis_color : hint_color;
uniform float emphasis_amout : hint_range(0.0, 1.0);

void vertex()
{
	VAR1 = VERTEX.y;
}

void fragment(){
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, emphasis_color.rgb, emphasis_amout);
	MODULATE;
	if (emphasis_amout <= 0.1){
		color *= MODULATE;
	}
	COLOR = color;
}

void light()
{
		SHADOW_VEC = vec2(0.0);
	{
		LIGHT_HEIGHT += 10.0;
		LIGHT_HEIGHT = -LIGHT_VEC.y + VAR1 ;
	}
	LIGHT *= 1.0;
}