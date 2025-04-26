extends State
class_name Climb

@export var climb_angle : float = 45

@export var climb_bar : ClimbBar
@export var walk : Walk
@export var climb_fall : ClimbFall

func _enter():
	climb_bar.update(needed_input)
	climb_bar.visible = true
	AudioManager.stop_loop("walk")
	#climb_speed = move_speed * 0.02s
	
func exit():
	climb_bar.visible = false
	
var needed_input : int = -1

var climb_speed = 0
@export var climb_deceleration = 0

func process_frame(delta: float) -> State:
	var _slant : float = parent.walk_line.get_slant(parent.position.x) # angle between -90 and 90
	parent.animation.flip_h = _slant < 0
	
	if(abs(_slant) <= climb_angle):
		parent.animation.flip_h = false
		return walk
	
	var _speed : float
	var climb_input : int = parent.climb_input
	
	#print("Needed Climb Input: ",needed_input)
	#print("Balance Input : ",climb_input)
	
	var _is_going_up : bool = _slant * (-parent.direction) < 0
	
	if(needed_input == climb_input
	or (Debug.climb_walk and parent.direction > 0)) :
		climb_speed = move_speed * delta
		needed_input *= -1
		climb_bar.update(needed_input)
		
	else : 
		if climb_speed > 0:
			climb_speed = max(climb_speed - climb_deceleration * delta,0)
			#climb_speed = clamp(climb_speed,0,climb_speed)
		if needed_input == -climb_input:
			return climb_fall
		#climb_bar.fall()
		#climb_speed = -1 if _is_going_up else 1 * move_speed * delta
		#print("Error in climb input")
		
	parent.position.x += climb_speed * (
		1 / (1 + abs(_slant / 9))
	)
	
	parent.move_to_floor(7)
	
	return null
