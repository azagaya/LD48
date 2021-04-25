extends RichTextLabel

export (String, MULTILINE) var raw_text := "" setget set_raw_text

func _ready():
	FontController.connect("joy_detection", self, "set_controller")
	set_controller(FontController.joy_name)
	modulate = Color.transparent
	Events.connect("show_ingame_message", self, "show_message")
	Events.connect("message_ended", self, "hide_message")

func set_controller(controller : String):
	bbcode_text = FontController.parse_string(controller, raw_text)

func set_raw_text(new_text):
	raw_text = new_text
	if not Engine.editor_hint:
		set_controller(FontController.joy_name)
	else:
		bbcode_text = new_text
		
func show_message(new_text := ""):
	if new_text != "":
		self.raw_text = new_text
	$Tween.stop_all()
	$Tween.interpolate_property(self, "modulate", Color.transparent, Color.white, 0.5)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	$AnimationPlayer.play("Showing")
	
func hide_message(now = false):
	$Tween.stop_all()
	$AnimationPlayer.stop()
	if now:
		modulate = Color.transparent
	else:
		$Tween.interpolate_property(self, "modulate", modulate, Color.transparent, 0.5)
		$Tween.start()
		yield($Tween,"tween_all_completed")
		$AnimationPlayer.play("Hide")
