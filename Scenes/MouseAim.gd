extends Area2D

var target = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	global_position = get_global_mouse_position()
	
func get_target_position():
	if target == null:
		return global_position + Vector2(0, 17)
	else:
		return target.global_position




func _on_MouseAim_area_entered(area):
	target = area.get_parent()


func _on_MouseAim_area_exited(area):
	target = null
