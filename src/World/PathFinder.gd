class_name PathFinder
extends Node

const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

export var Grid: Resource = preload("res://src/World/Grid.tres")
export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")
var _astar := AStar2D.new()
onready var terrain = $"../Terrain"

var walkable_cells := []
var move_type := 0

func _ready() -> void:
	var cell_mappings := {}
	for cell in walkable_cells:
		cell_mappings[cell] = Grid.as_index(cell)
	_add_and_connect_points(cell_mappings)

func get_terrain_move_cost(cell, moving_type) -> float:
	return TerrainData[terrain.get_cellv(cell)]["move_cost"][moving_type]

func _add_and_connect_points(cell_mappings: Dictionary) -> void:
	for point in cell_mappings:
		_astar.add_point(cell_mappings[point], point, get_terrain_move_cost(point, move_type))
	for point in cell_mappings:
		for neighbor_index in _find_neighbor_indices(point, cell_mappings):
			_astar.connect_points(cell_mappings[point], neighbor_index)

func _find_neighbor_indices(cell: Vector2, cell_mappings: Dictionary) -> Array:
	var out := []
	for direction in DIRECTIONS:
		var neighbor: Vector2 = cell + direction
		if not cell_mappings.has(neighbor):
			continue
		if not _astar.are_points_connected(cell_mappings[cell], cell_mappings[neighbor]):
			out.push_back(cell_mappings[neighbor])
	return out

func calculate_point_path(start: Vector2, end: Vector2) -> PoolVector2Array:
	var start_index: int = Grid.as_index(start)
	var end_index: int = Grid.as_index(end)
	if _astar.has_point(start_index) and _astar.has_point(end_index):
		return _astar.get_point_path(start_index, end_index)
	else:
		return PoolVector2Array()
