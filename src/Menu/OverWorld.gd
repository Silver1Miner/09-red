extends Control
# Over World

func _ready() -> void:
	$ToMission0.visible = PlayerData.completed_levels[0]
	$ToMission1.visible = PlayerData.completed_levels[0]
	$ToMission2.visible = PlayerData.completed_levels[1]
	$ToMission3.visible = PlayerData.completed_levels[2]

func _on_ToMission1_pressed() -> void:
	print("mission 1")

func _on_ToMission2_pressed() -> void:
	print("mission 2")

func _on_ToMission3_pressed() -> void:
	print("mission 3")

func _on_ToMission0_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_0) != OK:
		push_error("fail to load world")
