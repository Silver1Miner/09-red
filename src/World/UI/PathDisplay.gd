extends TileMap

func _ready() -> void:
	pass

func draw_path(current_path: Array) -> void:
	clear()
	for cell in current_path:
		set_cellv(cell, 0)
	update_bitmask_region()
