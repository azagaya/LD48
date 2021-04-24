extends Area2D

var speed := 100

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
	queue_free()
