extends StateMachine
class_name ScreenMachine

@export var transition : Transition
@export var level_timer : LevelTimer
@export var hud : Parallax2D
var next_state : State

func _ready():
	load_state(starting_state)
	
func change_state(new_state: State) -> void:
	if(transition.visible) : return
	transition.visible = true
	transition.play("close")
	AudioManager.play("transition",-10)
	next_state = new_state
	
func load_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	transition.play("open")
	current_state = new_state
	current_state.enter()
	
func _process(delta):
	process_frame(delta)
	transition.visible = transition.is_playing()


func _on_animated_sprite_2d_animation_finished():
	if(transition.animation.get_basename() == "close"):
		#await get_tree().create_timer(1).timeout
		load_state(next_state)
