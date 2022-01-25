extends Control

onready var quit_button = $Options/Quit
onready var settings_menu = $Settings

func _ready() -> void:
	if OS.get_name() == "HTML5":
		quit_button.visible = false

func _on_NewGame_pressed() -> void:
	print("New Game")
	if get_tree().change_scene("res://src/Menu/OverWorld.tscn") != OK:
		push_error("fail to load world")

func _on_LoadGame_pressed() -> void:
	print("Load Game")
	if get_tree().change_scene("res://src/Menu/OverWorld.tscn") != OK:
		push_error("fail to load world")

func _on_Settings_pressed() -> void:
	settings_menu.visible = true

func _on_Quit_pressed() -> void:
	get_tree().quit()
