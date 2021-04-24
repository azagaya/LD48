shader_type canvas_item;
varying float VAR1;
void vertex()
{
	VAR1 = VERTEX.y;
}
void light()
{
	if( ( LIGHT_VEC.y - VAR1 ) <= 0.0 )
	{
		SHADOW_VEC.y += -VAR1 + 1.0;
	}
	else
	{
		LIGHT *= 0.0;
	}
	LIGHT *= 1.0;
}