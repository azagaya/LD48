extends StaticBody2D

signal next_level

func _ready():
	pass
	
func _input(event):
	if $Area2D.get_overlapping_bodies().size() > 0:
		if event.is_action_pressed("Action"):
			emit_signal("next_level")


func _on_Area2D_body_entered(body):
	Events.emit_signal("show_ingame_message", "Down to next level [ACTION]")


func _on_Area2D_body_exited(body):
	Events.emit_signal("message_ended")
