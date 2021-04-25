tool
extends TileMap

export (NodePath) var walls_path
export (bool) var update_walls := false setget update_walls

func _ready():
	pass

func update_walls(u):
	if u:
		var walls : TileMap = get_node(walls_path)
		for cell in walls.get_used_cells():
			walls.set_cellv(cell, -1)
		var cells := get_used_cells()
		for cell in cells:
			walls.set_cellv(cell, 0)
			walls.update_bitmask_area(cell)

