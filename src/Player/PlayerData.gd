extends Node

var music_db = 0.5
var sound_db = 0.1
var completed_levels := [true, false, false, false]

func load_player_data() -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://red.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://red.save", File.READ)
	completed_levels = parse_json(save_game.get_line())
	music_db = parse_json(save_game.get_line())
	sound_db = parse_json(save_game.get_line())
	save_game.close()

func save_player_data() -> void:
	var save_game = File.new()
	save_game.open("user://red.save", File.WRITE)
	save_game.store_line(to_json(completed_levels))
	save_game.store_line(to_json(music_db))
	save_game.store_line(to_json(sound_db))
	save_game.close()

var main_menu := preload("res://src/Menu/MainMenu.tscn")
var over_world := preload("res://src/Menu/OverWorld.tscn")
var base_world := preload("res://src/world/World.tscn")
var level_0 := preload("res://src/World/Levels/Level0.tscn")
