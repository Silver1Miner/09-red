extends Node

const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

export var grid: Resource = preload("res://src/World/Grid.tres")
export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")
var _astar := AStar2D.new()
onready var terrain = $"../Terrain"

var attack_range_cells := []
func get_attack_range_cells(cell: Vector2, attack_range: Vector2) -> Array:
	attack_range_cells.clear()
	var stack := [cell]
	while not stack.empty():
		var current = stack.pop_back()
		if not grid.is_within_bounds(current):
			continue
		if current in attack_range_cells:
			continue
		var difference: Vector2 = (current - cell).abs()
		var distance := int(difference.x + difference.y)
		if distance > attack_range.y:
			continue
		if distance >= attack_range.x and distance <= attack_range.y:
			attack_range_cells.append(current)
		for direction in DIRECTIONS:
			var coordinates: Vector2 = current + direction
			if coordinates == cell:
				continue
			if coordinates in attack_range_cells:
				continue
			stack.append(coordinates)
	return attack_range_cells

var targets := []
func get_target_cells(team_target: int) -> Array:
	targets.clear()
	var team_units := {}
	if team_target == 0:
		team_units = get_parent().team1_units
	elif team_target == 1:
		team_units = get_parent().team2_units
	for cell in attack_range_cells:
		if team_units.has(cell) and team_units[cell] != get_parent()._active_unit:
			targets.append(cell)
	return targets
