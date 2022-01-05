extends Node2D

export var grid: Resource = preload("res://src/World/Grid.tres")
export var ui_cooldown := 0.1
onready var _timer: Timer = $Timer
onready var _camera: Camera2D = $Camera2D

export var cell := Vector2.ZERO setget set_cell
signal cursor_moved(cell)
signal accept_pressed(cell)
signal cancel_pressed(cell)

func _ready() -> void:
	_camera.reset_smoothing()
	_timer.wait_time = ui_cooldown
	set_cell(grid.get_cell_coordinates(position))
	position = grid.get_map_position(cell)

func bound_camera() -> void:
	_camera.limit_left = 0
	_camera.limit_top = 0
	_camera.limit_right = grid.get_map_bounds().x * grid.cell_size.x
	_camera.limit_bottom = grid.get_map_bounds().y * grid.cell_size.y
	_camera.reset_smoothing()

func set_cell(input: Vector2) -> void:
	var new_cell: Vector2 = grid.clamp_to_board(input)
	if new_cell.is_equal_approx(cell):
		return
	cell = new_cell
	position = grid.get_map_position(cell)

var past_cell := cell
func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		if grid.is_within_bounds(grid.get_cell_coordinates(get_global_mouse_position())):
			visible = true
			self.cell = grid.get_cell_coordinates(get_global_mouse_position())
			if cell != past_cell:
				emit_signal("cursor_moved", cell)
			past_cell = cell
		else:
			visible = false
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("click_left"):
		emit_signal("accept_pressed", cell)
		get_tree().set_input_as_handled()
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("click_right"):
		emit_signal("cancel_pressed", cell)
		get_tree().set_input_as_handled()
	var should_move = event.is_pressed()
	if event.is_echo():
		should_move = should_move and _timer.is_stopped()
	if not should_move:
		return
	if event.is_action("ui_right"):
		self.cell += Vector2.RIGHT
		emit_signal("cursor_moved", cell)
	elif event.is_action("ui_left"):
		self.cell += Vector2.LEFT
		emit_signal("cursor_moved", cell)
	if event.is_action("ui_up"):
		self.cell += Vector2.UP
		emit_signal("cursor_moved", cell)
	elif event.is_action("ui_down"):
		self.cell += Vector2.DOWN
		emit_signal("cursor_moved", cell)
