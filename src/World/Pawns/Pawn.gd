extends Path2D
class_name Pawn

signal walk_finished
enum STATE {READY, AWAITING_ORDER, WAIT}
enum STATUS {NORMAL, BURN}
enum TEAM {RED, BLU}
var pawn_state = STATE.READY
var status_effect = STATUS.NORMAL

export var pawn_type := 0
export var attack_range := Vector2(2,3)
export var hp := 20 setget _set_HP
export var max_hp := 20
export var attack := 15
export var defense := 8
export var move_range := 4
export var move_type := 0 # 0 Foot, 1 Tread, 2 Tire

export var team := TEAM.RED
export var grid: Resource = preload("res://src/World/Grid.tres")
export var PawnData: Resource = preload("res://src/Data/PawnData.tres")
export var move_speed := 300.0
export var cell := Vector2.ZERO setget set_cell
var prev_cell := cell
var is_selected := false setget set_is_selected
var _is_walking := false setget _set_is_walking
onready var _sprite: Sprite = $PathFollow2D/Sprite
onready var _anim_player: AnimationPlayer = $AnimationPlayer
onready var _path_follow: PathFollow2D = $PathFollow2D
onready var _hp_bar: TextureProgress = $PathFollow2D/TextureProgress
signal destroyed(cell)

func _ready() -> void:
	load_pawn_data()
	_hp_bar.max_value = max_hp
	_hp_bar.value = hp
	set_process(false)
	self.cell = grid.get_cell_coordinates(position)
	self.prev_cell = cell
	position = grid.get_map_position(cell)
	if not Engine.editor_hint:
		curve = Curve2D.new()

func load_pawn_data() -> void:
	max_hp = PawnData.data[pawn_type]["max_hp"]
	hp = max_hp
	move_range = PawnData.data[pawn_type]["move_range"]
	attack_range = PawnData.data[pawn_type]["attack_range"]
	attack = PawnData.data[pawn_type]["attack"]
	move_type = PawnData.data[pawn_type]["move_type"]

func _set_HP(new_hp) -> void:
	if hp != new_hp:
		hp = int(clamp(new_hp, 0, 99))
		_hp_bar.value = hp
	if hp == 0:
		destroyed()

func take_damage(damage) -> void:
	_set_HP(hp - damage)

func destroyed() -> void:
	emit_signal("destroyed", cell)
	queue_free()

# ======
# MOTION
# ======
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
	match pawn_state:
		STATE.WAIT:
			_anim_player.play("waiting")
		STATE.AWAITING_ORDER:
			_anim_player.play("selected")
		STATE.READY:
			_anim_player.play("idle")

func set_is_selected(value: bool) -> void:
	if pawn_state == STATE.WAIT:
		return
	is_selected = value
	if is_selected:
		set_pawn_state(STATE.AWAITING_ORDER)
	else:
		set_pawn_state(STATE.READY)

func _set_is_walking(value: bool) -> void:
	_is_walking = value
	set_process(_is_walking)
