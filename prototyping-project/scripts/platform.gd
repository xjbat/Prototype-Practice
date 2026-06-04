extends AnimatableBody2D

const SPEED = 200

var starting_pos: Vector2
@export var end_Node2D : Node2D

var desired_pos = starting_pos

enum States {GO_TO_START, GO_TO_END, STOP}
var state: States = States.STOP

func switch_to_start():
	state = States.GO_TO_START
func switch_to_end():
	state = States.GO_TO_END
	print("received")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	starting_pos = global_position
	Global.deactivate_platform.connect(switch_to_start)
	Global.activate_platform.connect(switch_to_end)
	print("connected")
	
func move_to_position(target_position: Vector2, delta: float) -> void:
	print("moving")
	global_position = global_position.move_toward(target_position, SPEED * delta)
	if (global_position == target_position):
		state = States.STOP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		States.GO_TO_START:
			move_to_position(starting_pos, delta)
		States.GO_TO_END:
			move_to_position(end_Node2D.global_position, delta)
		States.STOP:
			return
