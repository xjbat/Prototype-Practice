extends CharacterBody2D

@export_category("fat")
@export var fat_jump_velocity := -100.0
@export var fat_speed := 100.0
@export var fat_acceleration := 1.0
@export var fat_deceleration := 10.0

@export_category("thin")
@export var thin_jump_velocity := -200.0
@export var thin_speed := 300.0
@export var thin_acceleration := 2.0
@export var thin_deceleration := 10.0

@export_category("other")
@export var player_mesh : MeshInstance2D
@export var player_collision : CollisionShape2D

#TODO make this less fucked, good enough for now though!
func fat_movement():
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = fat_jump_velocity
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * fat_speed, fat_acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, fat_deceleration)

func thin_movement():
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = thin_jump_velocity
	
	var direction = Input.get_axis("left", "right")
	if direction:
		#direction * thin_speed
		velocity.x = move_toward(velocity.x, direction * thin_speed, thin_acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, thin_deceleration)

#TODO If a player scales in a small space weird behavior can occur, we should consider adding a check of some sort
func scale_player(size: float):
	print(player_mesh.scale.x, " : ", player_mesh.scale.y, " : ", player_collision.shape.radius)
	player_mesh.scale.x = size * 2
	player_mesh.scale.y = size * 2
	player_collision.shape.radius = size

func set_player_thin():
	scale_player(10)
	Global.playerState = Global.PlayerStates.THIN

func set_player_fat():
	scale_player(20)
	Global.playerState = Global.PlayerStates.FAT
	
func _ready() -> void:
	#make make sure player in thin when starting
	set_player_thin()
	Global.grow.connect(set_player_fat)
	Global.shrink.connect(set_player_thin)

func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	match Global.playerState:
		Global.PlayerStates.FAT:
			fat_movement()
		Global.PlayerStates.THIN:
			thin_movement()
		_:
			push_warning("PlayerState is invalid!")
			return
	
	#if Input.is_action_just_pressed("debug_00"):
		#set_player_thin()
	#if Input.is_action_just_pressed("debug_01"):
		#set_player_fat()
	
	move_and_slide()
