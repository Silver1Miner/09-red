extends Control

func play_turn_change(turn_count: int, whose_turn: String) -> void:
	$TurnCount/Count.text = "Turn " + str(turn_count)
	$TurnCount/Turn.text = whose_turn + str(" Turn")
	$AnimationPlayer.play("TurnCount")

func _on_AnimationPlayer_animation_started(_anim_name: String) -> void:
	visible = true

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	visible = false
