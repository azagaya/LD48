extends Control


func _ready():
	get_tree().paused=false

func _input(event):
	if event.is_action_pressed("Action"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
