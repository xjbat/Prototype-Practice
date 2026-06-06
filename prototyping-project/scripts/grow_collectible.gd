extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (Global.playerState != Global.PlayerStates.FAT and body is CharacterBody2D):
		Global.grow.emit()
		call_deferred("queue_free") 
