extends Area2D

@export var crunch_sound: AudioStreamMP3

func _on_body_entered(body: Node2D) -> void:
	if (Global.playerState != Global.PlayerStates.FAT and body is CharacterBody2D):
		Global.grow.emit()
		Global.play_audio(crunch_sound, global_position, 1)
		call_deferred("queue_free") 
