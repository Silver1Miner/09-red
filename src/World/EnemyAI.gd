extends YSort
# enemy AI controlled units are children

signal AI_finished()

func execute_AI_turn() -> void:
	for child in get_children():
		execute_order(child)
	emit_signal("AI_finished")

func execute_order(pawn: Pawn) -> void:
	print(pawn.cell)
	
