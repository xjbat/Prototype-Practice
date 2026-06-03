extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if (Global.playerState != Global.PlayerStates.FAT):
		Global.grow.emit()
		queue_free()
