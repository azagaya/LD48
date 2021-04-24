extends Area2D

var speed := 100

var damage := 1.0

var final_position := Vector2.ZERO
var initial_position := Vector2.ZERO
var half_position := Vector2.ZERO
var direction := Vector2.RIGHT
var max_height := 50.0

func _ready():
	direction = initial_position.direction_to(final_position)
	half_position = (initial_position+final_position)/2
	
func _physics_process(delta):
	global_position += speed*direction*delta
	$Sprite.position.y = -global_position.distance_to(final_position)*global_position.distance_to(initial_position)
	$Sprite.position.y *= max_height/(half_position.distance_to(final_position)*half_position.distance_to(initial_position))
	if global_position.distance_to(final_position) < 5:
		destroy()
		
func destroy():
	speed = 0
	$Sprite.hide()
	$Sprite2.hide()
	$Particles2D.emitting = true
	yield(get_tree().create_timer(0.75),"timeout")
	queue_free()


func _on_Area2D_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	destroy()
