extends State
class_name Falling

var death_time : float = 1.5
var death_timer : float = 0

func _enter():
	AudioManager.stop_loop("walk")
	AudioManager.play("fall",-10)
	AudioManager.play("death",-10)
	parent.player_camera.active = false
	
func process_frame(delta: float) -> State:
	parent.position.y += move_speed * delta
	#death_timer+= delta
	
	if(parent.position.y > parent.player_camera.position.y + 60):
		var game : Game = GameManager.main.get_node("ScreenMachine/Game")
		game.end_game()
	
	return null
