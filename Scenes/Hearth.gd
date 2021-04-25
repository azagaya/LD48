extends Sprite


func _ready():
	pass

func filled(fill := true):
	if fill:
		frame = 0
	else:
		frame = 1
	
