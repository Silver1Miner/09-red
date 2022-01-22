extends Node

export var map_size = Vector2(21, 16)
export var grid: Resource = preload("res://src/World/Grid.tres")
export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")

onready var terrain = $Terrain
onready var pathfinder = $PathFinder
onready var battle_manager = $BattleManager
onready var range_display = $RangeDisplay
onready var path_display = $PathDisplay
onready var cursor = $Cursor
onready var turn_change = $GUI/TurnChangeScreen
var team1_units := {}
var team2_units := {}

var _active_unit: Pawn
var _walkable_cells := []

var turn_count := 1

func _ready() -> void:
	if $EnemyAI.connect("AI_finished", self, "_on_AI_finished") != OK:
		push_error("AI signal connect fail")
	grid.board_size = map_size
	cursor.bound_camera()
	if cursor.connect("cursor_moved", self, "_on_cursor_moved") != OK:
		push_error("connect fail")
	if cursor.connect("accept_pressed", self, "_on_accept_pressed") != OK:
		push_error("connect fail")
	if cursor.connect("cancel_pressed", self, "_on_cancel_pressed") != OK:
		push_error("connect fail")
	if cursor.connect("attack_command", self, "_on_attack_command") != OK:
		push_error("connect fail")
	if cursor.connect("heal_command", self, "_on_heal_command") != OK:
		push_error("connect fail")
	if cursor.connect("build_command", self, "_on_build_command") != OK:
		push_error("connect fail")
	if cursor.connect("capture_command", self, "_on_capture_command") != OK:
		push_error("connect fail")
	if cursor.connect("item_command", self, "_on_item_command") != OK:
		push_error("connect fail")
	if cursor.connect("wait_command", self, "_on_wait_command") != OK:
		push_error("connect fail")
	if cursor.connect("focus_on_attack", self, "_on_focus_on_attack") != OK:
		push_error("connect fail")
	if cursor.connect("focus_on_heal", self, "_on_focus_on_heal") != OK:
		push_error("connect fail")
	if cursor.connect("end_turn", self, "_on_end_turn") != OK:
		push_error("connect fail")
	recount_units()
	turn_change.play_turn_change(turn_count, "Player")
	yield(get_tree().create_timer(3.0), "timeout")

func _unhandled_input(event: InputEvent) -> void:
	if _active_unit and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("click_right")):
		_deselect_active_unit()
		_clear_active_unit()

func _on_cursor_moved(cell) -> void:
	if cursor.cursor_state == cursor.STATE.TARGET and cursor.target_type == cursor.TARGET.ATTACK:
		cursor.update_defense_intel(team2_units[cell].hp, TerrainData.data[terrain.get_cellv(cell)]["defense"])
	elif _active_unit and _active_unit.is_selected and cell in _walkable_cells:
		var path = pathfinder.calculate_point_path(_active_unit.cell, cell)
		path_display.draw_path(path)

func _on_accept_pressed(cell) -> void:
	if cursor.cursor_state == cursor.STATE.TARGET:
		if cursor.target_type == cursor.TARGET.ATTACK:
			calculate_battle(cell)
		elif cursor.target_type == cursor.TARGET.HEAL:
			calculate_heal(cell)
	elif not is_occupied(cell) and not _active_unit:
		range_display.clear()
		cursor.set_cursor_state(cursor.STATE.MENU)
	elif not _active_unit:
		_select_unit(cell)
	elif _active_unit.is_selected:
		_move_active_unit(cell)

func _on_cancel_pressed(cell) -> void:
	if _active_unit:
		_cancel_move()
	elif cursor.cursor_state == cursor.STATE.MENU:
		cursor.set_cursor_state(cursor.STATE.MOVING)
		_clear_active_unit()
	else:
		_clear_active_unit()
		if team1_units.has(cell):
			# TODO: get pawn intel
			var intel_unit = team1_units[cell]
			var walkable = pathfinder.get_valid_endpoints(intel_unit.cell, intel_unit.move_range, intel_unit.move_type, 0)
			range_display.draw_attack(pathfinder.get_valid_attack_points(walkable, intel_unit.attack_range))
		elif team2_units.has(cell):
			var intel_unit = team2_units[cell]
			var walkable = pathfinder.get_valid_endpoints(intel_unit.cell, intel_unit.move_range, intel_unit.move_type, 1)
			range_display.draw_attack(pathfinder.get_valid_attack_points(walkable, intel_unit.attack_range))
		else:
			range_display.clear()
		print(TerrainData.data[terrain.get_cellv(cell)])

func is_occupied(cell: Vector2) -> bool:
	return true if team1_units.has(cell) or team2_units.has(cell) else false

func recount_units() -> void:
	team1_units.clear()
	team2_units.clear()
	for child in $Team1.get_children():
		var pawn := child as Pawn
		if not pawn:
			continue
		if pawn.connect("destroyed", self, "_on_team1_pawn_destroyed") != OK:
			push_error("connect fail")
		team1_units[pawn.cell] = pawn
	for child in $EnemyAI.get_children():
		var pawn := child as Pawn
		if not pawn:
			continue
		if pawn.connect("destroyed", self, "_on_team2_pawn_destroyed") != OK:
			push_error("connect fail")
		team2_units[pawn.cell] = pawn

func _on_team1_pawn_destroyed(cell) -> void:
	if !team1_units.erase(cell):
		push_error("cell not in team 1")
	create_explosion(cell)

func _on_team2_pawn_destroyed(cell) -> void:
	if !team2_units.erase(cell):
		push_error("cell not in team 2")
	create_explosion(cell)

func create_explosion(cell) -> void:
	var explosion = preload("res://src/World/Effects/Explosion.tscn")
	var explosion_instance = explosion.instance()
	$ObjectRegistry.register_effect(explosion_instance)
	explosion_instance.position = grid.get_map_position(cell) + Vector2(16,0)

func _select_unit(cell: Vector2) -> void:
	if team2_units.has(cell):
		_clear_active_unit()
		var walkable_cells = pathfinder.get_valid_endpoints(cell, team2_units[cell].move_range, team2_units[cell].move_type, 1)
		var attackable_cells = pathfinder.get_valid_attack_points_minus_move(walkable_cells, team2_units[cell].attack_range)
		range_display.draw_move_attack(walkable_cells, attackable_cells)
		return
	if not team1_units.has(cell):
		return
	if team1_units[cell].pawn_state == team1_units[cell].STATE.WAIT:
		print("unit has moved")
		return
	_active_unit = team1_units[cell]
	_active_unit.is_selected = true
	_walkable_cells = pathfinder.get_valid_endpoints(_active_unit.cell, _active_unit.move_range, _active_unit.move_type, 0)
	var attackable_cells = pathfinder.get_valid_attack_points_minus_move(_walkable_cells, _active_unit.attack_range)
	range_display.draw_move_attack(_walkable_cells, attackable_cells)
	cursor.valid_targets = battle_manager.get_target_cells(1)

func _deselect_active_unit() -> void:
	_active_unit.is_selected = false
	#_active_unit = null
	range_display.clear()
	path_display.clear()

func _clear_active_unit() -> void:
	_active_unit = null
	_walkable_cells.clear()

func _move_active_unit(end_cell: Vector2) -> void:
	if end_cell == _active_unit.cell:
		range_display.draw_attack(battle_manager.get_attack_range_cells(end_cell, _active_unit.attack_range))
		cursor.valid_targets = battle_manager.get_target_cells(1)
		cursor.set_cursor_state(cursor.STATE.COMMAND)
		cursor.get_node("UnitMenu/Attack").visible = (len(battle_manager.get_target_cells(1)) > 0)
		cursor.get_node("UnitMenu/Heal").visible = (_active_unit.pawn_type == 7 and len(battle_manager.get_target_cells(0)) > 0)
		cursor.get_node("UnitMenu/Build").visible = (_active_unit.pawn_type == 6 and terrain.get_cellv(end_cell) in TerrainData.buildable_cells)
		cursor.get_node("UnitMenu/Capture").visible = (_active_unit.pawn_type == 9 and terrain.get_cellv(end_cell) in TerrainData.capturable_cells)
		return
	elif is_occupied(end_cell) or not end_cell in _walkable_cells:
		return
	cursor.set_cursor_state(cursor.STATE.WAIT)
	_active_unit.walk_along(pathfinder.calculate_point_path(_active_unit.cell, end_cell))
	yield(_active_unit, "walk_finished")
	range_display.draw_attack(battle_manager.get_attack_range_cells(end_cell, _active_unit.attack_range))
	cursor.valid_targets = battle_manager.get_target_cells(1)
	cursor.set_cursor_state(cursor.STATE.COMMAND)
	cursor.get_node("UnitMenu/Attack").visible = (len(battle_manager.get_target_cells(1)) > 0)
	cursor.get_node("UnitMenu/Heal").visible = (_active_unit.pawn_type == 7 and len(battle_manager.get_target_cells(0)) > 0)
	cursor.get_node("UnitMenu/Build").visible = (_active_unit.pawn_type == 6 and terrain.get_cellv(end_cell) in TerrainData.buildable_cells)
	cursor.get_node("UnitMenu/Capture").visible = (_active_unit.pawn_type == 9 and terrain.get_cellv(end_cell) in TerrainData.capturable_cells)

func _confirm_move() -> void:
	if not team1_units.erase(_active_unit.prev_cell):
		print("unit not found")
	team1_units[_active_unit.cell] = _active_unit
	_active_unit.prev_cell = _active_unit.cell
	_deselect_active_unit()
	cursor.set_cursor_state(cursor.STATE.MOVING)
	_active_unit.set_pawn_state(_active_unit.STATE.WAIT)
	_clear_active_unit()

func _cancel_move() -> void:
	cursor.set_cursor_state(cursor.STATE.MOVING)
	_active_unit.undo_move()
	_deselect_active_unit()
	_clear_active_unit()

func _on_focus_on_attack() -> void:
	cursor.set_target_type(cursor.TARGET.ATTACK)
	#cursor.valid_targets = battle_manager.get_target_cells(1)
	range_display.draw_attack(battle_manager.get_attack_range_cells(_active_unit.cell, _active_unit.attack_range))

func _on_focus_on_heal() -> void:
	cursor.set_target_type(cursor.TARGET.HEAL)
	#cursor.valid_targets = battle_manager.get_target_cells(0)
	range_display.draw_heal(battle_manager.get_attack_range_cells(_active_unit.cell, _active_unit.attack_range))

func _on_attack_command() -> void:
	print("attack command")
	#range_display.draw_attack(battle_manager.get_attack_range_cells(_active_unit.cell, _active_unit.attack_range))
	cursor.valid_targets = battle_manager.get_target_cells(1)
	cursor.set_target_type(cursor.TARGET.ATTACK)
	cursor.set_cursor_state(cursor.STATE.TARGET)
	#cursor.valid_targets = battle_manager.get_target_cells(1)
	print(cursor.valid_targets)
	#_confirm_move()

func _on_heal_command() -> void:
	print("heal command")
	cursor.valid_targets = battle_manager.get_target_cells(0)
	cursor.set_target_type(cursor.TARGET.HEAL)
	cursor.set_cursor_state(cursor.STATE.TARGET)
	print(cursor.valid_targets)

func _on_build_command() -> void:
	print("build command")
	change_terrain(_active_unit.cell)

func calculate_battle(target_cell: Vector2) -> void:
	print("unit at ", _active_unit.cell, " attacked unit at ", target_cell)
	var damage = clamp(_active_unit.attack - TerrainData.data[terrain.get_cellv(target_cell)]["defense"],0,100)
	print(damage, " damage")
	if _active_unit.pawn_type == 3:
		if team2_units[target_cell].pawn_type != 3:
			team2_units[target_cell].set_on_fire()
	team2_units[target_cell].take_damage(damage)
	_confirm_move()

func calculate_heal(target_cell: Vector2) -> void:
	print("unit at ", _active_unit.cell, " healing unit at ", target_cell)
	team1_units[target_cell].take_damage(-10)
	team1_units[target_cell].extinguish_fire()
	_confirm_move()

func change_terrain(target_cell: Vector2) -> void:
	print("unit at ", _active_unit.cell, " changing terrain at ", target_cell)
	if terrain.get_cellv(target_cell) in TerrainData.buildable_cells:
		var target = terrain.get_cellv(target_cell)
		terrain.set_cellv(target_cell, TerrainData.buildable_cells[target])
	_confirm_move()

func _on_item_command() -> void:
	print("item command")
	_confirm_move()

func _on_capture_command() -> void:
	print("win game")
	_confirm_move()

func _on_wait_command() -> void:
	print("wait")
	_confirm_move()

func _on_end_turn() -> void:
	print("end turn")
	for unit in $Team1.get_children():
		unit.set_pawn_state(unit.STATE.READY)
	cursor.visible = false
	turn_change.play_turn_change(turn_count, "Enemy")
	yield(get_tree().create_timer(3.0), "timeout")
	$EnemyAI.execute_AI_turn()

func _on_AI_finished() -> void:
	print("AI finished")
	turn_count += 1
	turn_change.play_turn_change(turn_count, "Player")
	yield(get_tree().create_timer(3.0), "timeout")
	cursor.visible = true
	cursor.set_cursor_state(cursor.STATE.MOVING)
