extends Area2D

@export var victory_sound: AudioStreamMP3
const RED_FLAG = preload("uid://cxf5654pbopel")
const GREEN_FLAG = preload("uid://djwgxd4gu8o8h")
@onready var sprite_2d: Sprite2D = $Sprite2D

func change_to_red():
	sprite_2d.texture = RED_FLAG
	
func change_to_green():
	sprite_2d.texture = GREEN_FLAG
	
func _ready() -> void:
	Global.shrink.connect(change_to_green)
	Global.grow.connect(change_to_red)


#Probably should freeze the player or something so they can't move around during the victory sequence But kind of low priority.
func _on_body_entered(body: Node2D) -> void:
	if (Global.playerState == Global.PlayerStates.THIN
	 and body is CharacterBody2D):
		
		var audio = Global.play_audio(victory_sound, global_position, 1)
		print(audio.finished)
		audio.finished.connect(change_level)
		Global.pause_scene.call_deferred()

func change_level():
	Global.change_scene()
