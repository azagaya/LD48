extends Control


func _ready():
	hide()
	
func _input(event):
	if not visible: return
	if event.is_action_pressed("Action"):
		hide_dialog()
		get_tree().set_input_as_handled()
	
func show_dialog(message : String):
	get_tree().paused = true
	$Panel/RichTextLabel.raw_text = message
	show()

func hide_dialog():
	hide()
	get_tree().paused = false
