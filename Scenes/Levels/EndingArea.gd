extends Area2D

export (String, MULTILINE) var dialog := "[center]Lit all the torches.[/center]"

func _ready():
	pass

func _input(event):
	if get_overlapping_bodies().size() == 0:
		return
	if event.is_action_pressed("Action"):
		$CanvasLayer2/Dialog.show_dialog(dialog)
		get_tree().change_scene("res://Scenes/EndingScene.tscn")

func _on_EndingArea_body_entered(body):
	Events.emit_signal("show_ingame_message", "Inspect [ACTION]")


func _on_EndingArea_body_exited(body):
	Events.emit_signal("message_ended")
