extends Area2D

export (String, MULTILINE) var bot_label_message := "Talk with [ACTION]"
export (String, MULTILINE) var dialog := "[center]Lit all the torches.[/center]"

export var grant_hability := ""

func _ready():
	pass


func _on_NPC_body_entered(_body):
	Events.emit_signal("show_ingame_message", bot_label_message)


func _on_NPC_body_exited(_body):
	Events.emit_signal("message_ended")
	
func _unhandled_input(event):
	if get_overlapping_bodies().size() == 0:
		return
	if event.is_action_pressed("Action"):
		Events.emit_signal("message_ended",true)
		if grant_hability != "" and not grant_hability in Events.player_habilities:
			var habilities = Events.player_habilities
			habilities.append(grant_hability)
			Events.player_habilities = habilities
			
		$CanvasLayer/Dialog.show_dialog(dialog)
