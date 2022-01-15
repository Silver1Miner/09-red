extends AnimatedSprite

func _ready() -> void:
	play()

func _on_Explosion_animation_finished() -> void:
	queue_free()
