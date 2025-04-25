extends Screen
class_name Game

@export var game_over : GameOver
@export var victory : Victory

func end_game():
	get_parent().change_state(game_over)

func win_game():
	get_parent().change_state(victory)
	
func process_frame(delta: float) -> State:
	if(Input.is_action_just_pressed("reset")):
		return self
	return null
#func reset():
	#get_parent().change_state(self)
