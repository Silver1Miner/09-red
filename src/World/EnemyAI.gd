extends YSort
# enemy AI controlled units are children

onready var pathfinder = $"../PathFinder"
onready var battle_manger = $"../BattleManager"
signal AI_finished()

var agent_cell = Vector2.ZERO

func execute_AI_turn() -> void:
	agent_cell = get_parent().get_node("Team1/Agent").cell
	print(agent_cell)
	for child in get_children():
		execute_order(child)
	emit_signal("AI_finished")

func execute_order(pawn: Pawn) -> void:
	var move_range = pathfinder.get_valid_endpoints(pawn.cell, pawn.move_range, pawn.move_type)
	var attackable_cells = pathfinder.get_valid_attack_points(move_range, pawn.attack_range)
	var target = null
	for cell in attackable_cells:
		if cell in get_parent().team1_units:
			pawn.guarding = false
			target = cell
			break
	if pawn.guarding:
		print(pawn.cell, target, pawn.guarding)
		return
	else:
		print(pawn.cell, target, pawn.guarding)
