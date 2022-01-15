extends Node

func register_effect(effect: Node) -> void:
	call_deferred("add_child", effect)

func clear_screen() -> void:
	for n in get_children():
		remove_child(n)
		n.queue_free()
