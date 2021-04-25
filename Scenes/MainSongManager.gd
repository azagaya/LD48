extends Node2D


func play():
	$AudioStreamPlayer.play()
	
func _process(delta):
	if $AudioStreamPlayer.get_playback_position() > 76.8:
		$AudioStreamPlayer.play(9.6)
