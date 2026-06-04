extends Node

enum PlayerStates {THIN, FAT}
var playerState = PlayerStates.THIN

signal grow
signal shrink
signal activate_platform
signal deactivate_platform
@onready var root = get_node("../root")   
@export var scenes = []
#hacky fix so level one loads first
var scene_index = -1
var current_scene

#changed from root.add_child() to call_deferred("add_child") to get the output to shut up
func _ready() -> void:
	current_scene = scenes[scene_index].instantiate()
	root.call_deferred("add_child", current_scene)
	change_scene()

func change_scene():
	current_scene.queue_free()
	scene_index += 1
	current_scene = scenes[scene_index].instantiate()
	root.call_deferred("add_child", current_scene)
	
