extends Area2D

var is_pressed: bool = false

func _ready() -> void:
	Global.shrink.connect(check_for_thin)

func check_for_thin():
	if (is_pressed and Global.playerState == Global.PlayerStates.THIN):
		Global.deactivate_platform.emit()
		is_pressed = false

func _on_body_entered(body: Node2D) -> void:
	if (Global.playerState == Global.PlayerStates.FAT):
		Global.activate_platform.emit()
		is_pressed = true

func _on_body_exited(body: Node2D) -> void:
	if (Global.playerState == Global.PlayerStates.FAT):
		Global.deactivate_platform.emit()
		is_pressed = false
