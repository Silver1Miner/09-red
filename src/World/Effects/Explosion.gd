extends AnimatedSprite

func _ready() -> void:
	play()
	AudioManager.play_sound(PlayerData.explosion_sound)

func _on_Explosion_animation_finished() -> void:
	queue_free()
