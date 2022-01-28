extends Control
# Over World
export var TextData: Resource = preload("res://src/Data/TextData.tres")

func _ready() -> void:
	#$ToMission0.visible = PlayerData.completed_levels > 0
	$ToMission1.visible = PlayerData.completed_levels > 0
	$ToMission2.visible = PlayerData.completed_levels > 1
	$ToMission3.visible = PlayerData.completed_levels > 2
	if PlayerData.completed_levels >= 9:
		$Textbox.initialize(TextData.overworld_text[9])
	elif PlayerData.completed_levels >= 2:
		$Textbox.initialize(TextData.overworld_text[2])
	elif PlayerData.completed_levels >= 1:
		$Textbox.initialize(TextData.overworld_text[1])
	elif PlayerData.completed_levels >= 0:
		$Textbox.initialize(TextData.overworld_text[0])

func _on_ToMission0_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_0) != OK:
		push_error("fail to load world")

func _on_ToMainMenu_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.main_menu) != OK:
		push_error("fail to load world")

func _on_ToMission1_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_1) != OK:
		push_error("fail to load world")

func _on_ToMission2_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_2) != OK:
		push_error("fail to load world")

func _on_ToMission3_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_3) != OK:
		push_error("fail to load world")

func _on_ToMission4_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_4) != OK:
		push_error("fail to load world")

func _on_ToMission5_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_5) != OK:
		push_error("fail to load world")

func _on_ToMission6_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_6) != OK:
		push_error("fail to load world")

func _on_ToMission7_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_7) != OK:
		push_error("fail to load world")

func _on_ToMission8_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_8) != OK:
		push_error("fail to load world")

func _on_ToMission9_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.level_9) != OK:
		push_error("fail to load world")
