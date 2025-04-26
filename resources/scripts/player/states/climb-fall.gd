extends State
class_name ClimbFall

@export var idle : Idle
@export var climb : Climb
@export var climb_bar : ClimbBar
@export var falling : Falling

@export var climb_angle : float = 45
@export var hold_time : float = 0.5
@export var max_fall_time : float = 1

var hold_timer : float = 0
var fall_timer : float = 0

func _enter():
	fall_timer = 0
	climb_bar.visible = true
	climb_bar.fall()

func exit():
	climb_bar.visible = false

func process_frame(delta: float) -> State:
	var _slant : float = parent.walk_line.get_slant(parent.position.x)
	
	if(abs(_slant) <= climb_angle):
		#parent.animation.flip_h = false
		if(fall_timer > max_fall_time):
			return falling
		return idle
		
	var hold_right : bool = Input.is_action_pressed("balance_right")
	var hold_left : bool = Input.is_action_pressed("balance_left")
	
	climb_bar.left_hand.on = !hold_left
	climb_bar.left_hand.position.y = 0 if hold_left else - climb_bar.up_offset
	climb_bar.right_hand.on = !hold_right
	climb_bar.right_hand.position.y = 0 if hold_right else - climb_bar.up_offset
	
	if(hold_left and hold_right):
		RumbleManager.medium()
		hold_timer += delta
	else :
		if(hold_left or hold_right): RumbleManager.small()
		hold_timer = 0
		
	if(hold_timer > hold_time):
		return climb
	#var _is_going_up : bool = _slant < 0
	
	parent.position.x += (-1 if _slant > 0 else 1) * move_speed * delta
	
	parent.walk_line.move_to_floor(parent,10)
	
	#if(fall_timer > max_fall_time):
		#return falling
	
	fall_timer += delta
	return null
	
