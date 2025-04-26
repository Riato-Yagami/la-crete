extends State
class_name Walk

@export var idle : State
@export var climb : Climb
@export var creteWalk : CreteWalk
@export var falling : Falling

@export var foot_print : GPUParticles2D

@export var walk_back_speed_modifier : float = 0.5

func _enter():
	#foot_print.emitting = true
	parent.animation.flip_h = false
	AudioManager.start_loop("walk")

#func exit():
	#if(foot_print): foot_print.emitting = false
	
func process_frame(delta: float) -> State:
	#print(is_on_crete)
	
	#var point_id = parent.walk_line.get_point_id(parent.position.x)
	#print("Player point id : ",point_id)
	if(parent.walk_line.is_off_bound(parent.position.x)):
		return falling
		
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
