extends Node

export var map_size = Vector2(25, 18)
export var grid: Resource = preload("res://src/World/Grid.tres")
export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")

onready var terrain = $Terrain
onready var pathfinder = $PathFinder
onready var move_range_display = $MoveRangeDisplay
var team1_units := {}
var team2_units := {}

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

func _on_cursor_moved(_cell) -> void:
	pass
	#print("cursor moved to ", cell)

func _on_accept_pressed(cell) -> void:
	print("pressed accept at ", cell)

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
