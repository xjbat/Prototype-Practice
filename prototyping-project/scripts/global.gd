extends Node

enum PlayerStates {THIN, FAT}
var playerState = PlayerStates.THIN

signal grow
signal shrink
signal activate_platform
signal deactivate_platform
@onready var root = get_node("../root")   
@export var scenes = []
var scene_index = 0
var current_scene

func _ready() -> void:
	current_scene = scenes[scene_index].instantiate()
	root.add_child(current_scene)
	change_scene()

func change_scene():
	current_scene.queue_free()
	scene_index += 1
	current_scene = scenes[scene_index].instantiate()
	root.add_child(current_scene)	
	
