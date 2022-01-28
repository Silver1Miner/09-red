extends Control
# Over World
export var TextData: Resource = preload("res://src/Data/TextData.tres")

func _ready() -> void:
	#$ToMission0.visible = PlayerData.completed_levels[0]
	$ToMission1.visible = PlayerData.completed_levels[0]
	$ToMission2.visible = PlayerData.completed_levels[1]
	$ToMission3.visible = PlayerData.completed_levels[2]
	if PlayerData.completed_levels[3]:
		$Textbox.initialize(TextData.overworld_text[3])
	elif PlayerData.completed_levels[2]:
		$Textbox.initialize(TextData.overworld_text[2])
	elif PlayerData.completed_levels[1]:
		$Textbox.initialize(TextData.overworld_text[1])
	elif PlayerData.completed_levels[0]:
		$Textbox.initialize(TextData.overworld_text[0])

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
