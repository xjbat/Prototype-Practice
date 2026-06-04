extends Area2D
func _on_body_entered(body: Node2D) -> void:
	if (Global.playerState == Global.PlayerStates.FAT):
		Global.activate_platform.emit()

func _on_body_exited(body: Node2D) -> void:
	if (Global.playerState == Global.PlayerStates.FAT):
		Global.deactivate_platform.emit()
