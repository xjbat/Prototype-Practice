extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body is CharacterBody2D):
		Global.reset_scene.call_deferred()
		print("Player fell")
		queue_free()
