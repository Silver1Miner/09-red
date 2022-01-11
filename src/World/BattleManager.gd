extends Node

const DIRECTIONS = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

export var grid: Resource = preload("res://src/World/Grid.tres")
export var TerrainData: Resource = preload("res://src/Data/TerrainData.tres")
var _astar := AStar2D.new()
onready var terrain = $"../Terrain"

func get_attackable_cells(cell: Vector2, attack_range: Vector2) -> Array:
	var attackable_cells := []
	var stack := [cell]
	while not stack.empty():
		var current = stack.pop_back()
		if not grid.is_within_bounds(current):
			continue
		if current in attackable_cells:
			continue
		var difference: Vector2 = (current - cell).abs()
		var distance := int(difference.x + difference.y)
		if distance > attack_range.y:
			continue
		if distance >= attack_range.x and distance <= attack_range.y:
			attackable_cells.append(current)
		for direction in DIRECTIONS:
			var coordinates: Vector2 = current + direction
			if coordinates == cell:
				continue
			if coordinates in attackable_cells:
				continue
			stack.append(coordinates)
	return attackable_cells
