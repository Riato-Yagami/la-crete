extends State
class_name Walk

@export var idle : State
@export var climb : State
@export var creteWalk : CreteWalk

@export var walk_back_speed_modifier : float = 0.5

func process_frame(delta: float) -> State:
	#print(is_on_crete)
		
	var _slant : float = parent.walk_line.get_slant(parent.position.x) # angle between -90 and 90
	if(abs(_slant) > climb.climb_angle): return climb
	
	if(parent.is_on_crete):
		return creteWalk
		
	if(!parent.walk_input) : return idle
	
	move(delta,_slant)
	
	#print("Height : " + str(parent.height))
	
	return null

func move(delta,slant):
	var _speed : float = move_speed * delta
	
	if(parent.direction < 0) : _speed *= walk_back_speed_modifier
	#print("Slant : " + str(_slant)) 
	#position.x += _direction * _speed
	var _is_going_up : bool = slant * (-parent.direction) < 0
	#print("Is going up : " + str(_is_going_up))
	#parent.position.x += _direction * _speed
	parent.position.x += parent.direction * _speed * (
		1 / (1 + abs(slant / 10))
		if _is_going_up
		else 1
	)
	
	parent.move_to_floor()
