extends TileMap

func draw_move(cells: Array) -> void:
	clear()
	for cell in cells:
		set_cellv(cell, 0)

func draw_attack(cells: Array) -> void:
	clear()
	for cell in cells:
		set_cellv(cell, 1)

func draw_heal(cells: Array) -> void:
	clear()
	for cell in cells:
		set_cellv(cell, 2)

func draw_move_attack(move_cells: Array, attack_cells: Array) -> void:
	clear()
	for cell in move_cells:
		set_cellv(cell, 0)
	for cell in attack_cells:
		set_cellv(cell, 1)
