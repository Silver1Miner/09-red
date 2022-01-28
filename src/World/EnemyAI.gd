extends YSort
# enemy AI controlled units are children

export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")
onready var pathfinder = $"../PathFinder"
onready var battle_manager = $"../BattleManager"
onready var terrain = $"../Terrain"
onready var cursor = $"../Cursor"
signal AI_finished()

var agent_cell = Vector2.ZERO

func execute_AI_turn() -> void:
	if get_parent().has_node("Team1/Agent"):
		agent_cell = get_parent().get_node("Team1/Agent").cell
	else:
		push_error("agent was destroyed")
	print(agent_cell)
	for child in get_children():
		if child.take_fire_damage():
			cursor.set_cell(child.cell)
			yield(get_tree().create_timer(0.5), "timeout")
	for child in get_children():
		if child:
			execute_order(child)
		yield(get_tree().create_timer(1.0), "timeout")
		child.set_pawn_state(child.STATE.READY)
	emit_signal("AI_finished")

func execute_order(pawn: Pawn) -> void:
	var move_range = pathfinder.get_valid_endpoints(pawn.cell, pawn.move_range, pawn.move_type, pawn.team)
	var attackable_cells = pathfinder.get_valid_attack_points(move_range, pawn.attack_range)
	var target_cell = null
	for cell in attackable_cells:
		if cell in get_parent().team1_units:
			pawn.guarding = false
			target_cell = cell
			break
	if pawn.guarding:
		pass
	elif target_cell:
		AI_attack(pawn, move_range, target_cell)
	else:
		AI_chase(pawn, move_range, agent_cell)

func AI_chase(pawn: Pawn, move_range: Array, target_cell: Vector2) -> void:
	var min_distance = null
	var goal_cell = Vector2.ZERO
	for cell in move_range:
		var difference: Vector2 = (target_cell - cell).abs()
		var distance := int(difference.x + difference.y)
		if not min_distance or distance < min_distance and not get_parent().is_occupied(cell):
			min_distance = distance
			goal_cell = cell
	AI_move(pawn, goal_cell)

func AI_attack(pawn: Pawn, move_range: Array, target_cell: Vector2) -> void:
	for cell in move_range:
		if not get_parent().is_occupied(cell) and target_cell in battle_manager.get_attack_range_cells(cell, pawn.attack_range):
			AI_move(pawn, cell)
			yield(get_tree().create_timer(0.5), "timeout")
			AI_battle(pawn, target_cell)
			break

func AI_battle(pawn: Pawn, target_cell: Vector2) -> void:
	print(pawn.cell)
	var damage = clamp(int(pawn.attack/2.0) - TerrainData.data[terrain.get_cellv(target_cell)]["defense"],0,100)
	if pawn.pawn_type == 3:
		if get_parent().team1_units[target_cell].pawn_type != 3:
			get_parent().team1_units[target_cell].set_on_fire()
	get_parent().team1_units[target_cell].take_damage(damage)

func AI_move(pawn, end_cell) -> void:
	cursor.set_cell(end_cell)
	if get_parent().is_occupied(end_cell):
		print("ai trying to move into occupied cell")
	pawn.walk_along(pathfinder.calculate_point_path(pawn.cell, end_cell))
	if not get_parent().team2_units.erase(pawn.prev_cell):
		print("unit not found")
	get_parent().team2_units[pawn.cell] = pawn
	pawn.prev_cell = pawn.cell
