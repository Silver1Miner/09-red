extends Node

export var map_size = Vector2(25, 18)
export var Grid: Resource = preload("res://src/World/Grid.tres")

func _ready() -> void:
	Grid.board_size = map_size
	$Cursor.bound_camera()
	if $Cursor.connect("cursor_moved", self, "_on_cursor_moved") != OK:
		push_error("connect fail")
	if $Cursor.connect("accept_pressed", self, "_on_accept_pressed") != OK:
		push_error("connect fail")
	if $Cursor.connect("cancel_pressed", self, "_on_cancel_pressed") != OK:
		push_error("connect fail")

func _on_cursor_moved(_cell) -> void:
	pass
	#print("cursor moved to ", cell)

func _on_accept_pressed(cell) -> void:
	print("pressed accept at ", cell)

func _on_cancel_pressed(cell) -> void:
	print("pressed cancel at ", cell)
