extends Node2D

export (PackedScene) var next_level

export var available_habilities := []

onready var animation := $AnimationPlayer

func _on_Intro_next_level():
	if next_level:
		for gomen in get_tree().get_nodes_in_group("Gomens"):
			if gomen.grant_hability != "":
				if not gomen.grant_hability in Events.player_habilities:
					Events.player_habilities.append(gomen.grant_hability)
		next_level()

func repeat_level():
	animation.play("LevelOut")
	yield(animation,"animation_finished")
	get_tree().reload_current_scene()
	
func next_level():
	get_tree().paused = true
	animation.play("LevelOut")
	yield(animation,"animation_finished")
	get_tree().paused = false
	get_tree().change_scene_to(next_level)
	

func _on_Character_dead():
	repeat_level()
