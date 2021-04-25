extends Node

var player_habilities := ["Melee", "Shoot"] setget set_habilites

signal show_ingame_message(raw_text)
signal message_ended(now)
signal habilities_changed
signal enemy_died

func set_habilites(h : Array):
	player_habilities = h
	emit_signal("habilities_changed")
