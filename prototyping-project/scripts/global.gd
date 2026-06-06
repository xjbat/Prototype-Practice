extends Node

enum PlayerStates {THIN, FAT}
var playerState = PlayerStates.THIN

@warning_ignore("unused_signal")
signal grow
@warning_ignore("unused_signal")
signal shrink
@warning_ignore("unused_signal")
signal activate_platform
@warning_ignore("unused_signal")
signal deactivate_platform
@onready var root = get_node("../root")   
@export var scenes = []
#hacky fix so level one loads first
var scene_index = 0
var current_scene

#changed from root.add_child() to call_deferred("add_child") to get the output to shut up
func _ready() -> void:
	current_scene = scenes[scene_index].instantiate()
	root.call_deferred("add_child", current_scene)
	reset_scene()

func change_scene():
	scene_index += 1
	if (scene_index >= len(scenes)):
		push_warning("No next scene available")
		scene_index -= 1
	else:
		current_scene.queue_free()
		current_scene = scenes[scene_index].instantiate()
		root.call_deferred("add_child", current_scene)
		
func reset_scene():
	scene_index -= 1
	change_scene()



func _on_restart_button_pressed() -> void:
	reset_scene()
