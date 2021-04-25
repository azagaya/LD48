extends Node

var joy_name := "Keyboard"

var xbox_font := "res://XBOX.tres"
var ps_font := "res://PS.tres"
var kb_font := "res://KeyboardFont.tres"
var common_font := "res://Pixeltype.ttf"

var actions_bbcode := {
	"XBOX": {
		"[LEFT]": "[color=gray][font=%s]4[/font][/color]" % xbox_font,
		"[RIGHT]": "[color=gray][font=%s]6[/font][/color]" % xbox_font,
		"[UP]": "[color=gray][font=%s]8[/font][/color]" % xbox_font,
		"[LEFTUP]": "[color=gray][font=%s]7[/font][/color]" % xbox_font,
		"[RIGHTUP]": "[color=gray][font=%s]9[/font][/color]" % xbox_font,
		"[LEFTDOWN]": "[color=gray][font=%s]1[/font][/color]" % xbox_font,
		"[RIGHTDOWN]": "[color=gray][font=%s]3[/font][/color]" % xbox_font,
		"[DOWN]": "[color=gray][font=%s]2[/font][/color]" % xbox_font,
		"[ACTION]": "[color=gray][font=%s]][/font][/color]" % xbox_font,
		"[ATTACK]": "[color=gray][font=%s]}[/font][/color]" % xbox_font,
		"[SHOOT]" : "[color=gray][font=%s]a[/font][/color]" % xbox_font,
	},
	"PS": {
		"[LEFT]": "[color=gray][font=%s]4[/font][/color]" % ps_font,
		"[RIGHT]": "[color=gray][font=%s]6[/font][/color]" % ps_font,
		"[UP]": "[color=gray][font=%s]8[/font][/color]" % ps_font,
		"[LEFTUP]": "[color=gray][font=%s]7[/font][/color]" % ps_font,
		"[RIGHTUP]": "[color=gray][font=%s]9[/font][/color]" % ps_font,
		"[LEFTDOWN]": "[color=gray][font=%s]1[/font][/color]" % ps_font,
		"[RIGHTDOWN]": "[color=gray][font=%s]3[/font][/color]" % ps_font,
		"[DOWN]": "[color=gray][font=%s]2[/font][/color]" % ps_font,
		"[ACTION]": "[color=gray][font=%s]][/font][/color]" % ps_font,
		"[ATTACK]": "[color=gray][font=%s]}[/font][/color]" % ps_font,
		"[SHOOT]" : "[color=gray][font=%s]x[/font][/color]" % ps_font,
	},
	"Keyboard": {
		"[JUMP]": "[color=gray][font=%s]wx[/font][/color]" % kb_font,
		"[LEFT]": "[color=gray][font=%s]A[/font][/color]" % kb_font,
		"[RIGHT]": "[color=gray][font=%s]D[/font][/color]" % kb_font,
		"[UP]": "[color=gray][font=%s]W[/font][/color]" % kb_font,
		"[DOWN]": "[color=gray][font=%s]S[/font][/color]" % kb_font,
		"[ACTION]": "[color=gray][font=%s]E[/font][/color]" % kb_font,
		"[ATTACK]" : "[color=gray][font=%s]b[/font][/color]" % kb_font,
		"[SHOOT]" : "[color=gray][font=%s]a[/font][/color]" % kb_font,
	}}

func _ready():
	pass
	
func parse_string(controller_name : String, msg : String) -> String:
	var new_msg := msg
	controller_name = parse_controller(controller_name)
	for action in actions_bbcode[controller_name]:
		new_msg = new_msg.replace(action, actions_bbcode[controller_name][action])
	return new_msg
	
func parse_controller(controller : String) -> String:
	var joy_name : String
	if "PS" in controller or "Playstation" in controller:
		joy_name = "PS"
	elif controller == "Keyboard":
		joy_name = "Keyboard"
	else:
		joy_name = "XBOX"
		
	return joy_name
