extends Area2D


var direction := Vector2.RIGHT
var speed := 350.0

var damage := 1.0

func _ready():
	pass


func _process(delta):
	$RayCast2D.cast_to = direction*speed*delta
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		global_position = $RayCast2D.get_collision_point()
	else:
		global_position += speed*direction*delta
	


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	destroy()
	
func destroy():
	speed = 0
	$Sprite.hide()
	$Sprite2.hide()
	$Particles2D2.emitting = false
	$Particles2D.emitting = true
	yield(get_tree().create_timer(0.75),"timeout")
	queue_free()
