extends KinematicBody2D

var target = null
export var damage = 1
export var health := 3.0
export var speed := 35.0

onready var state_animation := $StateAnimation

func _ready():
	pass

func _physics_process(delta):
	if target != null:
		var direction := global_position.direction_to(target.global_position)
		if global_position.distance_to(target.global_position) > 5:
			move_and_slide(direction*speed)

func _on_DetectionArea_body_entered(body):
	target = body
	state_animation.play("Detected")
	
func take_damage(damage : float, dealer = null):
	health -= damage
	$EmphasisAnimation.play("Damaged")
	if health <= 0:
		queue_free()


func _on_Area2D_area_entered(area):
	state_animation.play("MouseOver")


func _on_Area2D_area_exited(area):
	state_animation.play("MouseOut")


func _on_HitBox_body_entered(_body):
	$AttackTimer.start()


func _on_HitBox_body_exited(_body):
	$AttackTimer.stop()


func _on_AttackTimer_timeout():
	for body in $HitBox.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(damage)
