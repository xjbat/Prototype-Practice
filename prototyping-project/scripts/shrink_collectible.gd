extends Area2D

@export var workout_sound: AudioStreamMP3

func _on_body_entered(body: Node2D) -> void:
	if (Global.playerState != Global.PlayerStates.THIN and body is CharacterBody2D):
		Global.shrink.emit()
		Global.play_audio(workout_sound, global_position, 1)
		queue_free()
