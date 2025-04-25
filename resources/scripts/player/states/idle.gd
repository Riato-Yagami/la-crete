extends State

@export var walk : State

func _enter():
	AudioManager.stop_loop("walk")
	
func process_frame(delta: float) -> State:
	if(parent.walk_input):
		return walk
	
	parent.move_to_floor()
	
	return null
