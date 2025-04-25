extends Screen
class_name Victory

@export var game : Game
@export var start : Start

func _enter():
	get_parent().level_timer.clock.pause()

func process_frame(delta: float) -> State:
	if(Input.is_action_just_pressed("move_forward")):
		return game
	if(Input.is_action_just_pressed("move_backward")):
		return start
	return null
