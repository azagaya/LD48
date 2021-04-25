extends Camera2D

var shake_strength := 0.0

func shake(strength = 3):
	shake_strength = strength
	
func _physics_process(delta):
	position = shake_strength * Vector2(randf(), randf())
	shake_strength = max(0, shake_strength - 10*delta)
