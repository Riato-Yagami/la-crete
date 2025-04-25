extends Walk
class_name CreteWalk

@export var walk : Walk
@export var unbalanced : Unbalanced
func _enter():
	parent.balance_bar.visible = true
	
func process_frame(delta: float) -> State:
	var _slant : float = parent.walk_line.get_slant(parent.position.x) # angle between -90 and 90
	var is_on_crete = parent.walk_line.cretes_parent.is_on_crete(parent.walk_line.get_point_id(parent.position.x))
	
	if(!parent.is_on_crete):
		parent.balance_bar.visible = false
		return walk
		
	#update_balance(delta)
	
	#if(!parent.walk_input) :
		#return idle
	if(parent.balance_bar.is_unbalanced):
		return unbalanced
		
	move(delta,_slant)
	
	#print("Height : " + str(parent.height))
	
	return null
