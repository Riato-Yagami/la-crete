extends Node2D
class_name ClimbBar

@export var left_hand : IButton
@export var right_hand : IButton

@export var up_offset : float = 13

@export var player : Player

func fall():
	left_hand.on = true
	right_hand.on = true
	left_hand.position.y = - up_offset
	right_hand.position.y = - up_offset
	
func update(needed_input : int):
	var _slant : float = player.walk_line.get_slant(player.position.x)
	var left : bool = needed_input == -1
	RumbleManager.small()
	#print("need left input : ", left)
	left_hand.on = left
	left_hand.position.y = - sign(_slant) * (up_offset if left else lerpf(left_hand.position.y,0,0.5))
	right_hand.on = !left
	right_hand.position.y = - sign(_slant) * (up_offset if !left else lerpf(right_hand.position.y,0,0.5))
