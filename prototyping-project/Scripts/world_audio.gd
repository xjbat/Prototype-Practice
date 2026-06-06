extends Node2D

@export var audio_player_count := 8
var audio_streams : Array[AudioStreamPlayer2D] = []

func create_audio_players():
	for i in audio_player_count:
		var audio_player = AudioStreamPlayer2D.new()
		call_deferred("add_child", audio_player)
		audio_streams.append(audio_player)

func get_audio():
	for stream in audio_streams:
		if stream.playing:
			continue
		return stream

func play_audio(file: AudioStreamMP3, position: Vector2, volume: float):
	var audio = get_audio()
	audio.stream = file
	audio.volume_db = volume
	audio.global_position = position
	audio.play()
	return audio

func _ready():
	create_audio_players()
	Global.world_audio = self
