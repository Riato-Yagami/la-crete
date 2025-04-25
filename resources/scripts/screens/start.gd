extends Screen
class_name Start

@export var game : Game

func process_frame(delta: float) -> State:
	if(Input.is_action_just_pressed("move_forward")):
		return game
	return null
