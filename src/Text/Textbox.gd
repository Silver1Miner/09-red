extends Control

var page := "0"
var text_playing = true
var dialogue = {}
onready var timer := $Timer
onready var text := $Sections/TextBox/Text
onready var next_button := $Sections/ButtonBox/Next
onready var skip_button := $Sections/ButtonBox/Skip

signal text_finished()
var test_dialogue = {
	"0": {"name":"red", "profile":"red",
	"text":"0123456789!"},
	"1": {"name":"red", "profile":"red",
	"text":"the quick brown fox jumps over the lazy dog"},
}

func _ready() -> void:
	timer.wait_time = 0.05
	timer.autostart = true
	#initialize(test_dialogue)

func initialize(scene) -> void:
	visible = true
	timer.start()
	dialogue = scene.duplicate(true)
	text_playing = true
	page = "0"
	if not page in dialogue:
		end_text()
	text.set_bbcode(dialogue[page]["text"])
	text.set_visible_characters(0)
	set_process_input(true)

func end_text() -> void:
	visible = false
	emit_signal("text_finished")

func _on_Next_pressed() -> void:
	if text_playing:
		if text.get_visible_characters() > text.get_total_character_count():
			if int(page) < dialogue.size() - 1:
				page = str(int(page) + 1)
				text.set_bbcode(dialogue[page]["text"])
				text.set_visible_characters(0)
			elif int(page) >= dialogue.size() - 1:
				end_text()
		else:
			text.set_visible_characters(text.get_total_character_count())

func _on_Skip_pressed() -> void:
	if text_playing:
		end_text()

func _on_Timer_timeout() -> void:
	text.set_visible_characters(text.get_visible_characters()+1)
