extends Node2D
class_name ClimbBar

@export var left_hand : AnimatedSprite2D
@export var right_hand : AnimatedSprite2D

func update(needed_input : int):
	if(needed_input == -1):
		left_hand.play("open")
		right_hand.play("close")
	else :
		left_hand.play("close")
		right_hand.play("open")
