extends Control

onready var quit_button = $Options/Quit
onready var settings_menu = $Settings

func _ready() -> void:
	if OS.get_name() == "HTML5":
		quit_button.visible = false
	AudioManager.play_music("res://assets/Music/Red_Tactics.ogg")

func _on_NewGame_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.over_world) != OK:
		push_error("fail to load world")

func _on_LoadGame_pressed() -> void:
	if get_tree().change_scene_to(PlayerData.over_world) != OK:
		push_error("fail to load world")

func _on_Settings_pressed() -> void:
	settings_menu.visible = true

func _on_Quit_pressed() -> void:
	get_tree().quit()
