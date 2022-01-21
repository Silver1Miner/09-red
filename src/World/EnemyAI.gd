extends YSort
# enemy AI controlled units are children

export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")
onready var pathfinder = $"../PathFinder"
onready var battle_manager = $"../BattleManager"
onready var terrain = $"../Terrain"
signal AI_finished()

signal pawn_move_finished()
signal pawn_action_finished()

var agent_cell = Vector2.ZERO

func execute_AI_turn() -> void:
	agent_cell = get_parent().get_node("Team1/Agent").cell
	print(agent_cell)
	for child in get_children():
		yield(get_tree().create_timer(1.0), "timeout")
		execute_order(child)
	emit_signal("AI_finished")

func execute_order(pawn: Pawn) -> void:
	var move_range = pathfinder.get_valid_endpoints(pawn.cell, pawn.move_range, pawn.move_type)
	var attackable_cells = pathfinder.get_valid_attack_points(move_range, pawn.attack_range)
	var target_cell = null
	for cell in attackable_cells:
		if cell in get_parent().team1_units:
			pawn.guarding = false
			target_cell = cell
			break
	if pawn.guarding:
		print(pawn.cell, target_cell, pawn.guarding)
	elif target_cell:
		AI_attack(pawn, move_range, target_cell)
	else:
		# move
		print(pawn.cell, target_cell, pawn.guarding)
	emit_signal("pawn_action_finished")

func AI_attack(pawn: Pawn, move_range: Array, target_cell: Vector2) -> void:
	print(pawn.cell, target_cell, pawn.guarding)
	for cell in move_range:
		if target_cell in battle_manager.get_attack_range_cells(cell, pawn.attack_range):
			AI_move(pawn, cell)
			yield(self, "pawn_move_finished")
			AI_battle(pawn, target_cell)
			break

func AI_battle(pawn: Pawn, target_cell: Vector2) -> void:
	var damage = clamp(pawn.attack - TerrainData.data[terrain.get_cellv(target_cell)]["defense"],0,100)
	if pawn.pawn_type == 3:
		if get_parent().team1_units[target_cell].pawn_type != 3:
			get_parent().team1_units[target_cell].set_on_fire()
	get_parent().team1_units[target_cell].take_damage(damage)

func AI_move(pawn, end_cell) -> void:
	pawn.walk_along(pathfinder.calculate_point_path(pawn.cell, end_cell))
	if not get_parent().team2_units.erase(pawn.prev_cell):
		print("unit not found")
	get_parent().team2_units[pawn.cell] = pawn
	pawn.prev_cell = pawn.cell
	emit_signal("pawn_move_finished")
