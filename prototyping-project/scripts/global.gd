extends Node

enum PlayerStates {THIN, FAT}
var playerState = PlayerStates.THIN

var world_audio : Node2D

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
var scene_index = -1
var current_scene

#changed from root.add_child() to call_deferred("add_child") to get the output to shut up
func _ready() -> void:
	current_scene = scenes[scene_index].instantiate()
	root.call_deferred("add_child", current_scene)
	change_scene()

func change_scene():
	scene_index += 1
	if (scene_index >= len(scenes)):
		push_warning("No next scene available")
	else:
		current_scene.queue_free()
		current_scene = scenes[scene_index].instantiate()
		root.call_deferred("add_child", current_scene)
	
#returns the audio player so you can connect signals, As seen in the level change collectible. 
func play_audio(file: AudioStreamMP3, position: Vector2, volume: float):
	var audio = world_audio.play_audio(file, position, volume)
	return audio
