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

var starting_index = 4 # should normallly be set to 0
var scene_index = starting_index
var current_scene

#changed from root.add_child() to call_deferred("add_child") to get the output to shut up
func _ready() -> void:
	change_scene()

func change_scene(do_reset: bool = false):
	scene_index += 1
	if (scene_index > starting_index + 1 or do_reset):
		current_scene.queue_free()
		print("freed")
	else:
		print("not freed")
	
	current_scene = load("res://scenes/levels/level_" + str(scene_index) + ".tscn")
	current_scene = current_scene.instantiate()
	root.call_deferred("add_child", current_scene)
		
func reset_scene():
	scene_index -= 1
	change_scene(true)

func _on_restart_button_pressed() -> void:
	reset_scene()
		
#returns the audio player so you can connect signals, As seen in the level change collectible. 
func play_audio(file: AudioStreamMP3, position: Vector2, volume: float):
	var audio = world_audio.play_audio(file, position, volume)
	return audio
	
func pause_scene():
	current_scene.process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED
	
# kinda useless
func play_scene():
	current_scene.process_mode = Node.ProcessMode.PROCESS_MODE_INHERIT
