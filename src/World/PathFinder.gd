class_name PathFinder
extends Node

const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

export var grid: Resource = preload("res://src/World/Grid.tres")
export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")
var _astar := AStar2D.new()
onready var terrain = $"../Terrain"
onready var battle_manager = $"../BattleManager"

func cell_map(walkable_cells, moving_type) -> Dictionary:
	var cell_mappings := {}
	for cell in walkable_cells:
		cell_mappings[cell] = grid.as_index(cell)
	_add_and_connect_points(cell_mappings, moving_type)
	return cell_mappings

func get_flood_fill(cell: Vector2, max_distance: int) -> Array:
	var array := []
	var stack := [cell]
	while not stack.empty():
		var current = stack.pop_back()
		if not grid.is_within_bounds(current):
			continue
		if current in array:
			continue
		var difference: Vector2 = (current - cell).abs()
		var distance := int(difference.x + difference.y)
		if distance > max_distance:
			continue
		array.append(current)
		for direction in DIRECTIONS:
			var coordinates: Vector2 = current + direction
			if get_parent().is_occupied(coordinates):
				continue
			if coordinates in array:
				continue
			stack.append(coordinates)
	return array

func get_valid_endpoints(cell: Vector2, move_range: int, moving_type: int) -> Array:
	var endpoints = []
	var limits = get_flood_fill(cell, move_range)
	var cell_mappings = cell_map(limits, moving_type)
	for end in limits:
		if _astar.has_point(cell_mappings[end]) and get_path_move_cost(calculate_point_path(cell, end),moving_type) <= move_range and len(calculate_point_path(cell, end)) != 0:
			if not endpoints.has(end):
				endpoints.append(end)
	return endpoints

func get_valid_attack_points(endpoints: Array, attack_range: Vector2) -> Array:
	var attack_points = []
	for cell in endpoints:
		var points = battle_manager.get_attack_range_cells(cell, attack_range)
		for point in points:
			if not point in attack_points:
				attack_points.append(point)
	return attack_points

func get_valid_attack_points_minus_move(endpoints: Array, attack_range: Vector2) -> Array:
	var attack_points = []
	for cell in endpoints:
		var points = battle_manager.get_attack_range_cells(cell, attack_range)
		for point in points:
			if not point in attack_points and not point in endpoints:
				attack_points.append(point)
	return attack_points

func get_terrain_move_cost(cell: Vector2, moving_type: int) -> float:
	return TerrainData.data[terrain.get_cellv(cell)]["move_cost"][moving_type]

func _add_and_connect_points(cell_mappings: Dictionary, moving_type: int) -> void:
	for point in cell_mappings:
		if get_terrain_move_cost(point, moving_type) > 0 and get_terrain_move_cost(point, moving_type) < 10:
			_astar.add_point(cell_mappings[point], point, get_terrain_move_cost(point, moving_type))
	for point in cell_mappings:
		for neighbor_index in _find_neighbor_indices(point, cell_mappings):
			if _astar.has_point(cell_mappings[point]) and _astar.has_point(neighbor_index):
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
	var start_index: int = grid.as_index(start)
	var end_index: int = grid.as_index(end)
	if _astar.has_point(start_index) and _astar.has_point(end_index):
		return _astar.get_point_path(start_index, end_index)
	else:
		return PoolVector2Array()

func get_path_move_cost(path: PoolVector2Array, moving_type: int) -> int:
	var cost = 0
	for point in path:
		var point_cost = get_terrain_move_cost(point, moving_type)
		if point_cost > 0:
			cost += get_terrain_move_cost(point, moving_type)
	return cost
