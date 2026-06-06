extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if (Global.playerState != Global.PlayerStates.THIN and body is CharacterBody2D):
		Global.shrink.emit()
		queue_free()
