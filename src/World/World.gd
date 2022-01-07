extends Node

export var map_size = Vector2(21, 14)
export var grid: Resource = preload("res://src/World/Grid.tres")
export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")

onready var terrain = $Terrain
onready var pathfinder = $PathFinder
onready var move_range_display = $MoveRangeDisplay
onready var path_display = $PathDisplay
var team1_units := {}
var team2_units := {}

var _active_unit: Pawn
var _walkable_cells := []

func _ready() -> void:
	grid.board_size = map_size
	$Cursor.bound_camera()
	if $Cursor.connect("cursor_moved", self, "_on_cursor_moved") != OK:
		push_error("connect fail")
	if $Cursor.connect("accept_pressed", self, "_on_accept_pressed") != OK:
		push_error("connect fail")
	if $Cursor.connect("cancel_pressed", self, "_on_cancel_pressed") != OK:
		push_error("connect fail")
	recount_units()
	move_range_display.draw(pathfinder.get_valid_endpoints(Vector2(8,8), 7, 1))

func _unhandled_input(event: InputEvent) -> void:
	if _active_unit and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("click_right")):
		_deselect_active_unit()
		_clear_active_unit()

func _on_cursor_moved(cell) -> void:
	if _active_unit and _active_unit.is_selected and cell in _walkable_cells:
		var path = pathfinder.calculate_point_path(_active_unit.cell, cell)
		path_display.draw_path(path)

func _on_accept_pressed(cell) -> void:
	if not _active_unit:
		_select_unit(cell)
	elif _active_unit.is_selected:
		_move_active_unit(cell)

func _on_cancel_pressed(cell) -> void:
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
	_active_unit = team1_units[cell]
	_active_unit.is_selected = true
	_walkable_cells = pathfinder.get_valid_endpoints(_active_unit.cell, _active_unit.move_range, _active_unit.move_type)
	move_range_display.draw(_walkable_cells)

func _deselect_active_unit() -> void:
	_active_unit.is_selected = false
	move_range_display.clear()
	path_display.clear()

func _clear_active_unit() -> void:
	_active_unit = null
	_walkable_cells.clear()

func _move_active_unit(end_cell: Vector2) -> void:
	if is_occupied(end_cell) or not end_cell in _walkable_cells:
		return
	if not team1_units.erase(_active_unit.cell):
		print("unit not found")
	team1_units[end_cell] = _active_unit
	_deselect_active_unit()
	_active_unit.walk_along(pathfinder.calculate_point_path(_active_unit.cell, end_cell))
	yield(_active_unit, "walk_finished")
	_clear_active_unit()
