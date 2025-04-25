extends StateMachine
class_name ScreenMachine

@export var transition : Transition
var next_state : State

func _ready():
	load_state(starting_state)
	
func change_state(new_state: State) -> void:
	transition.visible = true
	transition.play("close")
	AudioManager.play("transition")
	next_state = new_state
	
func load_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	transition.play("open")
	current_state = new_state
	current_state.enter()
	
func _process(delta):
	process_frame(delta)
	transition.visible = transition.animation.is_playing()


func _on_animated_sprite_2d_animation_finished():
	if(transition.animation.animation.get_basename() == "close"):
		#await get_tree().create_timer(1).timeout
		load_state(next_state)
