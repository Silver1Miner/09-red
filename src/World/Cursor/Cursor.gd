extends Node2D

enum STATE {MOVING, COMMAND, MENU, TARGET}
var cursor_state = STATE.MOVING

export var grid: Resource = preload("res://src/World/Grid.tres")
export var ui_cooldown := 0.1
onready var _timer: Timer = $Timer
onready var _camera: Camera2D = $Camera2D

export var cell := Vector2.ZERO setget set_cell
signal cursor_moved(cell)
signal accept_pressed(cell)
signal cancel_pressed(cell)
signal attack_command()
signal item_command()
signal wait_command()
signal end_turn()

var valid_targets := []
var current_target := 0

func _ready() -> void:
	_camera.reset_smoothing()
	_timer.wait_time = ui_cooldown
	set_cell(grid.get_cell_coordinates(position))
	position = grid.get_map_position(cell)
	$UnitMenu.visible = (cursor_state == STATE.COMMAND)
	$MapMenu.visible = (cursor_state == STATE.MENU)
	$DefenseIntel.visible = (cursor_state == STATE.TARGET)

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

func set_cursor_state(state: int) -> void:
	cursor_state = state
	$UnitMenu.visible = (cursor_state == STATE.COMMAND)
	$MapMenu.visible = (cursor_state == STATE.MENU)
	$DefenseIntel.visible = (cursor_state == STATE.TARGET)
	if $UnitMenu.visible:
		$UnitMenu/Cancel.grab_focus()
	elif $MapMenu.visible:
		$MapMenu/Cancel.grab_focus()

var past_cell := cell
func _unhandled_input(event) -> void:
	if cursor_state == STATE.MOVING and event is InputEventMouseMotion:
		if grid.is_within_bounds(grid.get_cell_coordinates(get_global_mouse_position())):
			visible = true
			self.cell = grid.get_cell_coordinates(get_global_mouse_position())
			if cell != past_cell:
				emit_signal("cursor_moved", cell)
			past_cell = cell
		else:
			visible = false
	elif cursor_state == STATE.TARGET and event is InputEventMouseMotion:
		var cell_coord = grid.get_cell_coordinates(get_global_mouse_position())
		if grid.is_within_bounds(cell_coord) and cell_coord in valid_targets:
			visible = true
			self.cell = grid.get_cell_coordinates(get_global_mouse_position())
			emit_signal("cursor_moved", cell)
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("click_left"):
		if cursor_state == STATE.MOVING or cursor_state == STATE.TARGET:
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
	if cursor_state == STATE.MOVING and event.is_action("ui_right"):
		self.cell += Vector2.RIGHT
		emit_signal("cursor_moved", cell)
	elif cursor_state == STATE.MOVING and event.is_action("ui_left"):
		self.cell += Vector2.LEFT
		emit_signal("cursor_moved", cell)
	if event.is_action("ui_up"):
		if cursor_state == STATE.MOVING:
			self.cell += Vector2.UP
			emit_signal("cursor_moved", cell)
		elif cursor_state == STATE.TARGET:
			current_target += 1
			if current_target >= len(valid_targets):
				current_target = 0
			self.cell = valid_targets[current_target]
			emit_signal("cursor_moved", cell)
	elif event.is_action("ui_down"):
		if cursor_state == STATE.MOVING:
			self.cell += Vector2.DOWN
			emit_signal("cursor_moved", cell)
		elif cursor_state == STATE.TARGET:
			current_target -= 1
			if current_target < 0:
				current_target = 0
			self.cell = valid_targets[current_target]
			emit_signal("cursor_moved", cell)

func update_defense_intel(target_hp, target_defense) -> void:
	$DefenseIntel/Label.text = """HP: %s
DEF: %s""" % [str(target_hp), str(target_defense)]

func _on_Attack_pressed() -> void:
	emit_signal("attack_command")

func _on_Item_pressed() -> void:
	emit_signal("item_command")

func _on_Wait_pressed() -> void:
	emit_signal("wait_command")

func _on_Cancel_pressed() -> void:
	emit_signal("cancel_pressed", cell)

func _on_EndTurn_pressed() -> void:
	emit_signal("end_turn")
