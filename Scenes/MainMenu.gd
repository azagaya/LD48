extends Node2D


func _ready():
	Events.player_habilities = []
	$CanvasLayer/RichTextLabel.show_message()


func _on_Button2_pressed():
	get_tree().quit()


func _on_Button_pressed():
	MainSongManager.play()
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
