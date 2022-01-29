extends Node

var music_db = 0.5
var sound_db = 0.3
var completed_levels := 0

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
var base_world := preload("res://src/World/World.tscn")
var level_0 := preload("res://src/World/Levels/Level0.tscn")
var level_1 := preload("res://src/World/Levels/Level1.tscn")
var level_2 := preload("res://src/World/Levels/Level2.tscn")
var level_3 := preload("res://src/World/Levels/Level3.tscn")
var level_4 := preload("res://src/World/Levels/Level4.tscn")
var level_5 := preload("res://src/World/Levels/Level5.tscn")
var level_6 := preload("res://src/World/Levels/Level6.tscn")
var level_7 := preload("res://src/World/Levels/Level7.tscn")
var level_8 := preload("res://src/World/Levels/Level8.tscn")
var level_9 := preload("res://src/World/Levels/Level9.tscn")

var heal_sound := "res://assets/Sound/powerUp7.ogg"
var damage_sound := "res://assets/Sound/impactPunch_heavy_000.ogg"
var confirm_sound := "res://assets/Sound/select_005.ogg"
var cancel_sound := "res://assets/Sound/back_001.ogg"
var shoot_sound := "res://assets/Sound/346537__nioczkus__perdition-1911-pistol.ogg"
var shotgun_sound := "res://assets/Sound/163455__lemudcrab__shotgun-shot.wav"
var cannon_sound := "res://assets/Sound/581597__samsterbirdies__gun-cannon.ogg"
var flame_sound := "res://assets/Sound/447941__breviceps__blast-flamethrower-cooldown.wav"
var explosion_sound := "res://assets/Sound/Splode.wav"
var footstep := "res://assets/Sound/footstep_concrete_003.ogg"
var tread := "res://assets/Sound/387977__giddster__plastic-toy-rolling.wav"
var wheel := "res://assets/Sound/545204__daybreaker64__toy-car-tire-spin.wav"
var build_sound := "res://assets/Sound/engineCircular_000.ogg"
