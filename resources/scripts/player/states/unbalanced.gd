extends State
class_name Unbalanced

@export var creteWalk : CreteWalk
@export var falling : Falling

func _enter():
	#parent.player_camera.apply_shake()
	AudioManager.stop_loop("walk")
	
func process_frame(delta: float) -> State:
	if(!parent.balance_bar.is_unbalanced):
		return creteWalk
		
	if(parent.balance_bar.is_over):
		parent.balance_bar.visible = false
		return falling
	
	#print("Height : " + str(parent.height))
	
	return null
