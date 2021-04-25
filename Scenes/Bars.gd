extends StaticBody2D

onready var torches = get_tree().get_nodes_in_group("Torches")

func _ready():
	for torch in torches:
		torch.connect("lit", self, "torch_lit")


func activate():
	$AnimationPlayer.play("Open")

func torch_lit():
	for torch in torches:
		if not torch.is_on:
			return
			
	activate()
