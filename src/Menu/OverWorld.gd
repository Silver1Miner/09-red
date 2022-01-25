extends Control
# Over World

func _ready() -> void:
	$ToMission0.visible = PlayerData.level_status[0]
	$ToMission1.visible = PlayerData.level_status[0]
	$ToMission2.visible = PlayerData.level_status[1]
	$ToMission3.visible = PlayerData.level_status[2]

func _on_ToMission1_pressed() -> void:
	print("mission 1")

func _on_ToMission2_pressed() -> void:
	print("mission 2")

func _on_ToMission3_pressed() -> void:
	print("mission 3")

func _on_ToMission0_pressed() -> void:
	if get_tree().change_scene("res://src/world/World.tscn") != OK:
		push_error("fail to load world")
