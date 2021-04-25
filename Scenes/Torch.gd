extends StaticBody2D

var is_on := false
signal lit

func _ready():
	pass


func _on_Area2D_body_entered(body):
	body.health = 5
	is_on = true
	$Particles2D.emitting = true
	$AnimationPlayer.play("On")
	$AudioStreamPlayer2D.play()
	emit_signal("lit")
