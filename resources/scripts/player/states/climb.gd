extends State

@export var climb_angle : float = 45

@export var climb_bar : ClimbBar
@export var walk : State

func _enter():
	climb_bar.visible = true
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
	#print("Needed Climb Input: ",needed_input)
	#print("Balance Input : ",parent.balance_input)
	
	if(needed_input == parent.balance_input
	or (Debug.climb_walk and parent.direction > 0)) :
		climb_speed = move_speed * delta
		needed_input *= -1
		climb_bar.update(needed_input)
	else : if climb_speed > 0:
		climb_speed -= climb_deceleration * delta
		climb_speed = clamp(climb_angle,0,climb_speed)
	#var _speed : float = move_speed * delta
	#if(parent.direction < 0) : _speed *= walk_back_speed_modifier
	#print("Slant : " + str(_slant)) 
	#position.x += _direction * _speed
	var _is_going_up : bool = _slant * (-parent.direction) < 0
	#print("Is going up : " + str(_is_going_up))
	#parent.position.x += parent.direction * _speed
	parent.position.x += climb_speed * (
		1 / (1 + abs(_slant / 10))
	)
	
	parent.move_to_floor(7)
	
	return null
