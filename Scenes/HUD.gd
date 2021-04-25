extends Control

export (NodePath) var player_path 
onready var player := get_node(player_path)

func _ready():
	$ProgressBar.visible = player.lantern_max_time > 0

func health_changed(health):
	for i in $Hearts.get_child_count():
		$Hearts.get_child(i).filled(i < health)

func _physics_process(_delta):
	var progress = player.get_node("LightFuel").time_left/player.lantern_max_time
	$ProgressBar.value = progress * 100.0

