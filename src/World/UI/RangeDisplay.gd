extends TileMap

func draw_move(cells: Array) -> void:
	clear()
	for cell in cells:
		set_cellv(cell, 0)

func draw_attack(cells: Array) -> void:
	clear()
	for cell in cells:
		set_cellv(cell, 1)
