extends Control
# Over World

func _ready() -> void:
	pass
	#$ToMission0.visible = PlayerData.completed_levels[0]
	#$ToMission1.visible = PlayerData.completed_levels[0]
	#$ToMission2.visible = PlayerData.completed_levels[1]
	#$ToMission3.visible = PlayerData.completed_levels[2]

func _on_ToMission1_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_1) != OK:
		push_error("fail to load world")

func _on_ToMission2_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_2) != OK:
		push_error("fail to load world")

func _on_ToMission3_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_3) != OK:
		push_error("fail to load world")

func _on_ToMission0_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_0) != OK:
		push_error("fail to load world")

func _on_ToMainMenu_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.main_menu) != OK:
		push_error("fail to load world")
