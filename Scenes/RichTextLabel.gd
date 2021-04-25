extends RichTextLabel

export (String, MULTILINE) var raw_text := "" setget set_raw_text

func _ready():
	FontController.connect("joy_detection", self, "set_controller")
	set_controller(FontController.joy_name)
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
