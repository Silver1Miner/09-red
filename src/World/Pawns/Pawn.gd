extends Path2D
class_name Pawn

signal walk_finished
enum STATE {READY, AWAITING_ORDER, WAIT}
var pawn_state = STATE.READY

export var grid: Resource = preload("res://src/World/Grid.tres")
export var move_range := 4
export var move_type := 0 # 0 Foot, 1 Tread, 2 Tire
export var move_speed := 300.0
export var cell := Vector2.ZERO setget set_cell
var prev_cell := cell
var is_selected := false setget set_is_selected
var _is_walking := false setget _set_is_walking
onready var _sprite: Sprite = $PathFollow2D/Sprite
onready var _anim_player: AnimationPlayer = $AnimationPlayer
onready var _path_follow: PathFollow2D = $PathFollow2D

func _ready() -> void:
	set_process(false)
	self.cell = grid.get_cell_coordinates(position)
	self.prev_cell = cell
	position = grid.get_map_position(cell)
	if not Engine.editor_hint:
		curve = Curve2D.new()
	#test()

func test() -> void:
	var points := [
		Vector2(2, 3),
		Vector2(2, 6),
		Vector2(8, 7),
		Vector2(8, 9),
	]
	walk_along(PoolVector2Array(points))

func _process(delta: float) -> void:
	_path_follow.offset += move_speed * delta
	if _path_follow.unit_offset >= 1.0:
		self._is_walking = false
		_path_follow.offset = 0.0
		position = grid.get_map_position(cell)
		curve.clear_points()
		emit_signal("walk_finished")

func walk_along(path: PoolVector2Array) -> void:
	if path.empty():
		return
	curve.add_point(Vector2.ZERO)
	for point in path:
		curve.add_point(grid.get_map_position(point) - position)
	prev_cell = cell
	cell = path[-1]
	self._is_walking = true

func undo_move() -> void:
	set_cell(prev_cell)
	position = grid.get_map_position(cell)

func set_cell(value: Vector2) -> void:
	cell = grid.clamp_to_board(value)

func set_pawn_state(state: int) -> void:
	pawn_state = state
	if pawn_state == STATE.WAIT:
		$PathFollow2D/Sprite.self_modulate = Color(100/255.0,100/255.0,100/255.0)
	else:
		$PathFollow2D/Sprite.self_modulate = Color(1,1,1)

func set_is_selected(value: bool) -> void:
	if pawn_state == STATE.WAIT:
		return
	is_selected = value
	if is_selected:
		pawn_state = STATE.AWAITING_ORDER
		print("selected")
	else:
		pawn_state = STATE.READY
		print("idle")

func _set_is_walking(value: bool) -> void:
	_is_walking = value
	set_process(_is_walking)
