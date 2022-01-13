extends Node

export var map_size = Vector2(21, 14)
export var grid: Resource = preload("res://src/World/Grid.tres")
export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")

onready var terrain = $Terrain
onready var pathfinder = $PathFinder
onready var battle_manager = $BattleManager
onready var range_display = $RangeDisplay
onready var path_display = $PathDisplay
onready var cursor = $Cursor
var team1_units := {}
var team2_units := {}

var _active_unit: Pawn
var _walkable_cells := []

func _ready() -> void:
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
	if cursor.connect("item_command", self, "_on_item_command") != OK:
		push_error("connect fail")
	if cursor.connect("wait_command", self, "_on_wait_command") != OK:
		push_error("connect fail")
	if cursor.connect("end_turn", self, "_on_end_turn") != OK:
		push_error("connect fail")
	recount_units()
	range_display.draw_move(pathfinder.get_valid_endpoints(Vector2(8,8), 7, 1))

func _unhandled_input(event: InputEvent) -> void:
	if _active_unit and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("click_right")):
		_deselect_active_unit()
		_clear_active_unit()

func _on_cursor_moved(cell) -> void:
	if cursor.cursor_state == cursor.STATE.TARGET:
		cursor.update_defense_intel(team2_units[cell].hp, team2_units[cell].defense)
	elif _active_unit and _active_unit.is_selected and cell in _walkable_cells:
		var path = pathfinder.calculate_point_path(_active_unit.cell, cell)
		path_display.draw_path(path)

func _on_accept_pressed(cell) -> void:
	if cursor.cursor_state == cursor.STATE.TARGET:
		calculate_battle(cell)
	if not is_occupied(cell) and not _active_unit:
		cursor.set_cursor_state(cursor.STATE.MENU)
	if not _active_unit:
		_select_unit(cell)
	elif _active_unit.is_selected:
		_move_active_unit(cell)

func _on_cancel_pressed(cell) -> void:
	if _active_unit:
		_cancel_move()
	elif cursor.cursor_state == cursor.STATE.MENU:
		cursor.set_cursor_state(cursor.STATE.MOVING)
	else:
		if team1_units.has(cell):
			range_display.draw_attack(battle_manager.get_attack_range_cells(cell, team1_units[cell].attack_range))
		elif team2_units.has(cell):
			range_display.draw_attack(battle_manager.get_attack_range_cells(cell, team2_units[cell].attack_range))
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
		team1_units[pawn.cell] = pawn
	for child in $Team2.get_children():
		var pawn := child as Pawn
		if not pawn:
			continue
		team2_units[pawn.cell] = pawn

func _select_unit(cell: Vector2) -> void:
	if not team1_units.has(cell):
		return
	if team1_units[cell].pawn_state == team1_units[cell].STATE.WAIT:
		print("unit is wait")
		return
	_active_unit = team1_units[cell]
	_active_unit.is_selected = true
	_walkable_cells = pathfinder.get_valid_endpoints(_active_unit.cell, _active_unit.move_range, _active_unit.move_type)
	range_display.draw_move(_walkable_cells)

func _deselect_active_unit() -> void:
	_active_unit.is_selected = false
	range_display.clear()
	path_display.clear()

func _clear_active_unit() -> void:
	_active_unit = null
	_walkable_cells.clear()

func _move_active_unit(end_cell: Vector2) -> void:
	if end_cell == _active_unit.cell:
		cursor.set_cursor_state(cursor.STATE.COMMAND)
		range_display.draw_attack(battle_manager.get_attack_range_cells(end_cell, _active_unit.attack_range))
		return
	elif is_occupied(end_cell) or not end_cell in _walkable_cells:
		return
	cursor.set_cursor_state(cursor.STATE.COMMAND)
	_active_unit.walk_along(pathfinder.calculate_point_path(_active_unit.cell, end_cell))
	yield(_active_unit, "walk_finished")
	range_display.draw_attack(battle_manager.get_attack_range_cells(end_cell, _active_unit.attack_range))
	cursor.get_node("UnitMenu/Attack").visible = (len(battle_manager.get_target_cells(1)) > 0)
		
	#_clear_active_unit()

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

func _on_attack_command() -> void:
	print("attack command")
	range_display.draw_attack(battle_manager.get_attack_range_cells(_active_unit.cell, _active_unit.attack_range))
	cursor.set_cursor_state(cursor.STATE.TARGET)
	cursor.valid_targets = battle_manager.get_target_cells(1)
	print(cursor.valid_targets)
	#_confirm_move()

func calculate_battle(target_cell: Vector2) -> void:
	print("unit at ", _active_unit.cell, " attacked unit at ", target_cell)
	# TODO: battle calculation
	_confirm_move()

func _on_item_command() -> void:
	print("item command")
	_confirm_move()

func _on_wait_command() -> void:
	_confirm_move()

func _on_end_turn() -> void:
	print("end turn")
	for unit in $Team1.get_children():
		unit.set_pawn_state(unit.STATE.READY)
	cursor.set_cursor_state(cursor.STATE.MOVING)
