extends Control

export (String, MULTILINE) var intro := "" setget set_intro
signal next_level

func _ready():
	show()
	get_tree().paused = true
	
func _input(event):
	if not visible: return
	if event.is_action_pressed("Shoot"):
		get_tree().paused = false
		hide()
	elif event.is_action_pressed("Action"):
		emit_signal("next_level")

func set_intro(i : String):
	intro = i
	$Label.bbcode_text = intro
